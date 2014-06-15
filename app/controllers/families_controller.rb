class FamiliesController < ApplicationController
  def index
    @families = Family.all
  end

  def show
    @family = Family.new(params[:id])
  end
end
