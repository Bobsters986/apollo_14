class AstronautMissionsController < ApplicationController
  def create
    astronaut = Astronaut.find(params[:id])
    mission = Mission.find(params[:mission_id])
    AstronautMission.create!(astronaut: astronaut, mission: mission)

    redirect_to "/astronauts/#{astronaut.id}"
  end
end