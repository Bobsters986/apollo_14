class AstronautsController < ApplicationController
  def index
    @astronauts = Astronaut.all
    @astro_avg_age = Astronaut.average_age
  end
end