class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= ::User.new

    return unless user.present?

    can :read, :all
    can :manage, :all
  end
end
