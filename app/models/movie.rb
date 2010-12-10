class Movie < ActiveRecord::Base
  validates_presence_of :title, :description, :message => "is needed!"
  validates_length_of :description, :minimum => 10, :too_short => "is too short!"
  validates_uniqueness_of :title, :message => "corresponds to an existing movie!"
  validates_inclusion_of :rating, :in => %w[G PG PG-13 R NC-17], :message => "is not a valid rating!"
  
  def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-').downcase}"
  end
  
  # Returns a formatted version of the date:
  def release_date
    self.released_on.strftime('%B %d, %Y') if self.released_on
  end
  
  def self.required_age_for(rating)
    {
      "G"     =>  0,
      "PG"    =>  0,
      "PG-13" =>  13,
      "R"     =>  17,
      "NC-17" =>  17
    }[rating]
  end
  
  def appropriate_for_birthdate?(birthdate)
    latest_acceptable_time = Movie.required_age_for(self.rating).years.ago
    birthdate <= latest_acceptable_time
  end
  
  def self.find_all_appropriate_for_birthdate(birthdate)
    Movie.all.select do |movie|
      movie.appropriate_for_birthdate?(birthdate)
    end
  end

  # The API key for TMDb
  def self.tmdb_key
    "2f734792bb7269928501c7d9d5ef8337"
  end

  # Searches TMDb given a title, and returns an array of Movie objects.
  def self.find_from_tmdb(movie_title)
    require 'open-uri'
    require 'hpricot'
    search_string = CGI.escape(movie_title)
    remote_path = "http://api.themoviedb.org/2.1/Movie.search/en/xml/#{Movie.tmdb_key}/#{search_string}"
    doc = Hpricot(open(remote_path))
    movies_xml = doc/"movies/movie"
    if movies_xml.present?
      movies_xml.collect { |movie_xml| Movie.new_from_tmdb(movie_xml) }
    else
      []
    end
  end

  # Returns a Movie object, given an XML description of the movie.
  def self.new_from_tmdb(movie_xml)
    title = (movie_xml/"name").first.inner_html
    released = (movie_xml/"released").first.inner_html
    released_on = Date.parse(released) if released.present?
    certification = (movie_xml/"certification").first.inner_html
    overview = (movie_xml/"overview").first.inner_html

    @movie = Movie.new(
      :title => title,
      :released_on => released_on,
      :rating => certification,
      :description => overview
    )
  end
end
