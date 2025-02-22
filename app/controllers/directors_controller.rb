class DirectorsController < ApplicationController
  def update
    # Get the ID out of params
    d_id = params.fetch("the_id")

    # Look up the existing record
    matching_records = Director.where({ :id => d_id })
    the_director = matching_records.at(0)

    # Overwrite each column with the values from user inputs
    the_director.name = params.fetch("name")
    the_director.dob = params.fetch("dob")
    the_director.bio = params.fetch("bio")
    the_director.image = params.fetch("image")

    # Save
    the_director.save

    # Redirect to the director details page
    redirect_to("/directors/#{the_director.id}")
  end
  
  def create
    # Params hask looks like this:
    # {"name"=>"1", "dob"=>"2", "bio"=>"3", "image"=>"4"}

    d = Director.new
    d.name = params.fetch("name")
    d.dob = params.fetch("dob")
    d.bio = params.fetch("bio")
    d.image = params.fetch("image")

    d.save

    redirect_to("/directors")

    # Retrieve the user's inputs from params
    # Create a record in the movie table
    # Populate each column with the user input
    # Save

    # Redirect the user to the /directors URL
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Director.where({ :id => the_id })

    the_director = matching_records.at(0)

    the_director.destroy

    redirect_to("/directors")
  end

  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
