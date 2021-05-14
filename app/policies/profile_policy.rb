class ProfilePolicy < ApplicationPolicy
  def become_grandma?
    !@user.has_role? :grandma
  end
end
