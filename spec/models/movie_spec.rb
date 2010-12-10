require 'spec_helper'

describe Movie do
  before(:each) do
    @valid_attributes = {
      :title => "Pocahontas",
      :description => "A movie about the new world.",
      :rating => "G",
      :released_on => Time.parse("1/1/1995")
    }
  end

  it "should create a new instance given valid attributes" do
    Movie.create(@valid_attributes).should be_true
  end

  describe "when validating a movie" do
    it "should not allow a movie with no title" do
      @no_title_attributes = {
        :description => "A movie about the new world.",
        :rating => "G",
        :released_on => Time.parse("1/1/1995")
      }
      @movie = Movie.new(@no_title_attributes)
      @movie.should_not be_valid
    end

    it "should not allow a movie with no description" do
      @valid_attributes[:description] = nil
      @movie = Movie.new(@no_description)
      @movie.should_not be_valid
    end
   
    it "should not allow a movie with a title that is not unique" do
      Movie.create!(@valid_attributes)
      @movie = Movie.new(@valid_attributes)
      @movie.should_not be_valid
    end

    it "should not allow a movie with a description less than 10 characters long" do
      @valid_attributes[:description] = "123456789"
      @movie = Movie.new(@valid_attributes)
      @movie.should_not be_valid
    end

    it "should allow a movie with a valid movie rating" do
      @valid_attributes[:rating] = "NC-17"
      @movie = Movie.new(@valid_attributes)
      @movie.should be_valid
    end

    it "should not allow a movie with an invalid movie rating" do
      @valid_attributes[:rating] = "PG-17"
      @movie = Movie.new(@valid_attributes)
      @movie.should_not be_valid
    end
  end

  describe "when checking age-appropriateness" do
    # NOTE: Methods of the form be_something(arg) will automagically
    # call object.something?(arg). This feature of rspec makes reading
    # specs more natural.

    it "should be appropriate for a 15-year-old if rated G" do
      @valid_attributes[:rating] = "G"
      @movie = Movie.new(@valid_attributes)
      @movie.should be_appropriate_for_birthdate(15.years.ago)
    end

    it "should be appropriate for a 30-year-old if rated G" do
      @valid_attributes[:rating] = "G"
      @movie = Movie.new(@valid_attributes)
      @movie.should be_appropriate_for_birthdate(30.years.ago)
    end

    it "should not be appropriate for a 15-year-old if rated R" do
      @valid_attributes[:rating] = "R"
      @movie = Movie.new(@valid_attributes)
      @movie.should_not be_appropriate_for_birthdate(15.years.ago)
    end
  end
 
  describe "database finder for age-appropriateness" do
    # It is necessary to actually save records for these methods since they
    # iterate over saved records.

    it "should always include G rated movies" do
      @movie = Movie.create!(@valid_attributes)
      Movie.find_all_appropriate_for_birthdate(Time.now).should include(@movie)
    end

    it "should exclude R rated movies if age is less than 17" do
      @valid_attributes[:rating] = "R"
      @movie = Movie.create!(@valid_attributes)
      Movie.find_all_appropriate_for_birthdate(16.years.ago).should_not include(@movie)
    end
  end

end