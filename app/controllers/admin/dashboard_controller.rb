class Admin::DashboardController < ApplicationController
  # switch to using enviro variables
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']

  def show
    @category_count = Category.count
    @product_count = Product.count
  end
end
