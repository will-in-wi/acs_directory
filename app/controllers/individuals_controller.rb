class IndividualsController < ApplicationController
  def index
    @individuals = Individual.where family_position: 'Head'
  end
end
