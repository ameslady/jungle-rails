class Admin::DashboardController < ApplicationController
  # switch to using enviro variables
  http_basic_authenticate_with name: "Jungle", password: "book"

  def show
  end
end
