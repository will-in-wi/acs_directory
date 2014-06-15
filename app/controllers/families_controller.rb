class FamiliesController < ApplicationController
  def index
    @individuals = Individual.where(family_position: 'Head').order(last_name: :asc)
  end

  def show
    @family = Individual.where(family_id: params[:id])
  end
end
