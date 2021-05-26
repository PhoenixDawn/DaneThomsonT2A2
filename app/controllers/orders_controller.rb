class OrdersController < ApplicationController
  # Only retrieve orders a user has
  # From here we will be grabbing the listing attached to it
  def index
    @orders = Order.where(user_id: current_user.id)
  end
end
