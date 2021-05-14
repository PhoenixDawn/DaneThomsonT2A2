class ProfileController < ApplicationController
  def index
  end

  #POST to /profile to update Grandma status
  def add_role
    current_user.add_role :grandma
    redirect_to profile_path
  end
end
