class HomeController < ApplicationController
  def show
    @missions = Mission.all.order(:listing_id)
  end
end
