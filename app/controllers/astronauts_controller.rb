class AstronautsController < ApplicationController
  def index
    @astronauts = Astronaut.all
    @astro_avg_age = Astronaut.average_age
  end

  def show
    @astronaut = Astronaut.find(params[:id])
    @missions = @astronaut.sort_alpha
  end
end