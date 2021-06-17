class Ability
  include CanCan::Ability

  def initialize(user = nil)
    can :manage, :all
    cannot(%i[update destroy], Event) { |event| event.user != user }
  end
end
