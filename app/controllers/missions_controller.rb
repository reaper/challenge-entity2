class MissionsController < ApplicationController
  # GET /missions or /missions.json
  def index
    @missions = Mission.all
  end
end
