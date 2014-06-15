class FamiliesController < ApplicationController
  def index
    @individuals = Individual.where(family_position: 'Head').order(last_name: :asc)
  end
end
