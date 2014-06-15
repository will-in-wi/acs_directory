class IndividualsController < ApplicationController
  def index
    @individuals = Individual.all
  end
end
