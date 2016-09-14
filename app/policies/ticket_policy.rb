class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.try(:admin?) || record.project.roles.exists?(user_id: user)
  end

  def create?
    user.try(:admin?) || record.project.roles.exists?(user_id: user)
  end

  def update?
    user.try(:admin?) | record.project.roles.exists?(user_id: user)
  end

  def destroy?
    user.try(:admin?) | record.project.roles.exists?(user_id: user)
  end

end
