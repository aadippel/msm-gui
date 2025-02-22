class MoviesController < ApplicationController
  def create
    # Params hask looks like this:
    # {"title"=>"1", "year"=>"2", "duration"=>"3", "description"=>"4", "image"=>"5". "director_id"=>"6"}

    m = Movie.new
    m.title = params.fetch("title")
    m.year = params.fetch("year")
    m.duration = params.fetch("duration")
    m.description = params.fetch("description")
    m.image = params.fetch("image")
    m.director_id = params.fetch("director_id")

    m.save

    redirect_to("/movies")

    # Retrieve the user's inputs from params
    # Create a record in the movie table
    # Populate each column with the user input
    # Save

    # Redirect the user to the /movies URL
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Movie.where({ :id => the_id })

    the_movie = matching_records.at(0)

    the_movie.destroy

    redirect_to("/movies")
  end

  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
