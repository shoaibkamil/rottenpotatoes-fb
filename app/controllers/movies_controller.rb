class MoviesController < ApplicationController
  def index
    @movies = Movie.all.sort { |a, b| a.released_on <=> b.released_on }
  end
  
  def new
  end

  def find
    @movies = Movie.find_from_tmdb(params[:title])

    if @movies.blank?
      flash[:error] = "Movie not found. Try again!"
      @previous = params[:title]
      render :action => "new"
      flash[:error] = nil
    end
  end

  def create
    @movie = Movie.new(params[:movie])
    if @movie.save
      flash[:notice] = "#{@movie.title} added to Rotten Potatoes!"
      redirect_to movie_path(@movie)
    else
      render :action => "new"
    end
  end
  
  def show
    @movie = Movie.find(params[:id])
  end
  
  def edit
    @movie = Movie.find(params[:id])
  end
  
  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(params[:movie])
      flash[:notice] = "#{@movie.title} has been updated!"
      redirect_to movie_path(@movie)
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy
      flash[:notice] = "#{@movie.title} has been deleted!"
    else
      flash[:error] = "Failed to delete #{@movie.title}!"
    end
    redirect_to(movies_url)
  end
end
