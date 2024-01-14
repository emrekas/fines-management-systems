# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can [:login, :login_attempt, :register, :logout, :index], [User, HomeController], public: true

    if user != nil && user.role == 'individual'
      can [:read], [Vehicle, Fine], user_id: user.id
      can [:read, :edit, :update, :destroy], [User], id: user.id
    end

    if user != nil && user.role == 'admin'
      can :manage, :all
    end


  end
end
