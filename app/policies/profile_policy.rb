class ProfilePolicy < ApplicationPolicy
  def add_role?
    !@user.has_role? :grandma
  end
end
