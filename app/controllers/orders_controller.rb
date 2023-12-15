class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.includes(:products)
  end

  def admin; end
end
