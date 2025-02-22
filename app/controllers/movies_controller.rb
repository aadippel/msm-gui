class MoviesController < ApplicationController
  def update
    # Get the ID out of params
    m_id = params.fetch("the_id")

    # Look up the existing record
    matching_records = Movie.where({ :id => m_id })
    the_movie = matching_records.at(0)

    # Overwrite each column with the values from user inputs
    the_movie.title = params.fetch("title")
    the_movie.year = params.fetch("year")
    the_movie.duration = params.fetch("duration")
    the_movie.description = params.fetch("description")
    the_movie.image = params.fetch("image")
    the_movie.director_id = params.fetch("director_id")

    # Save
    the_movie.save

    # Redirect to the movie details page
    redirect_to("/movies/#{the_movie.id}")
  end

  def create
    # Params hask looks like this:
    # {"title"=>"1", "year"=>"2", "duration"=>"3", "description"=>"4", "image"=>"5". "director_id"=>"6"}

    # Populate each column with the user input
    m = Movie.new
    
    # Retrieve the user's inputs from params
    # Create a record in the movie table
    m.title = params.fetch("title")
    m.year = params.fetch("year")
    m.duration = params.fetch("duration")
    m.description = params.fetch("description")
    m.image = params.fetch("image")
    m.director_id = params.fetch("director_id")

    # Save
    m.save

    # Redirect the user to the /movies URL
    redirect_to("/movies")
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
