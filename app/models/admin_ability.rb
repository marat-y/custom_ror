class AdminAbility
  include CanCan::Ability

  def initialize(_user = nil)
    can :manage, :all
    cannot :create, Event
  end
end
