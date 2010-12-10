require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MoviesController do
  fixtures :movies

  #Delete this example and add some real ones
  it "should use MoviesController" do
    controller.should be_an_instance_of(MoviesController)
  end
  
  it "should save a valid movie" do
    movie = movies(:one)                          
    Movie.stub(:new).and_return(movie)
    movie.should_receive(:save).once
    post 'create', :movie => {:title => movies(:one).title,
                              :description => movies(:one).description,
                              :rating => movies(:one).rating,
                              :released_on => movies(:one).released_on}
  end
  
  it "should show results when api returns more than one movie" do
    Movie.should_receive(:find_from_tmdb).and_return([movies(:one), movies(:two)])
    get 'find', :title => 'pocahontas'
    assert_template 'find'
  end
  
  it "should be able to add one of the 5 movies" do
    # i don't really understand the question from the homework.
    # Saving a movie from an API call shouldn't be functionally any different
    # than defining your own movie.
    # I guess you can check that you are redirected to the show page.
    movie = movies(:one)
    Movie.stub(:new).and_return(movie)
    movie.should_receive(:save).and_return(true)
    post 'create', :movie => {:title => movies(:one).title,
                              :description => movies(:one).description,
                              :rating => movies(:one).rating,
                              :released_on => movies(:one).released_on}
    assert_redirected_to movie_path(movie)
  end
  
  it "should, when the api returns 0 movies, should render the new template" do
      Movie.stub(:find_from_tmdb).and_return([])
      get 'find', :title => 'the matrix'
      assert_template :new
  end
  

end
