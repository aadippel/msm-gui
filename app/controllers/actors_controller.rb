class ActorsController < ApplicationController
  def update
    # Get the ID out of params
    a_id = params.fetch("the_id")

    # Look up the existing record
    matching_records = Actor.where({ :id => a_id })
    the_actor = matching_records.at(0)

    # Overwrite each column with the values from user inputs
    the_actor.name = params.fetch("name")
    the_actor.dob = params.fetch("dob")
    the_actor.bio = params.fetch("bio")
    the_actor.image = params.fetch("image")

    # Save
    the_actor.save

    # Redirect to the actor details page
    redirect_to("/actors/#{the_actor.id}")
  end

  def create
    # Params hask looks like this:
    # {"name"=>"1", "dob"=>"2", "bio"=>"3", "image"=>"4"}

    a = Actor.new
    a.name = params.fetch("name")
    a.dob = params.fetch("dob")
    a.bio = params.fetch("bio")
    a.image = params.fetch("image")

    a.save

    redirect_to("/actors")

    # Retrieve the user's inputs from params
    # Create a record in the movie table
    # Populate each column with the user input
    # Save

    # Redirect the user to the /actors URL
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Actor.where({ :id => the_id })

    the_actor = matching_records.at(0)

    the_actor.destroy

    redirect_to("/actors")
  end

  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
