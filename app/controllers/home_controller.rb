class HomeController < ApplicationController
  def show
    @missions = Mission.all
  end
end
