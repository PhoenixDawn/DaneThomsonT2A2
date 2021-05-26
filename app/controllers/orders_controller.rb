class OrdersController < ApplicationController
  # Only retrieve listings that a user has
  # This is for the display page of a grandma
  def index
    @orders = Order.where(user_id: current_user.id)
  end
end
