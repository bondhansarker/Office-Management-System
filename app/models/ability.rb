class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.present?
      if user.role == 'Office Admin'
        can :manage, :all
        cannot :reject, Expense, {status: 'Rejected'}
        cannot :approve, Expense, {status: 'Rejected'}
        cannot :reject, Expense, {status: 'Approved'}
        cannot :update, Expense, {status: 'Approved'}
        cannot :update, Expense, {status: 'Rejected'}
      else
        can :update, User,{user_id: user.id}
        can :manage, Expense, {user_id: user.id}
        cannot :manage, Expense, {status: 'Rejected'}
        cannot :manage, Expense, {status: 'Approved'}
        cannot :approve, Expense, {user_id: user.id}
        cannot :reject, Expense, {user_id: user.id}
        can :read, Expense, {user_id: user.id}
      end
    else
      cannot :manage, :all
    end
  end
end


# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities