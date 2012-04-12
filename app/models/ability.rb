class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? :student
      can [:read, :show, :edit, :update], User, :id => user.id, :roles_mask => user.roles_mask
      cannot :index, User
      can :edit_my_details, User, :id => user.id
      can :update_my_details, User, :id => user.id
      can :edit_password, User, :id => user.id
      can :update_password, User, :id => user.id
      can :take, :survey
      can :create, :survey
      can :show, :survey
      can :index, Response, :user_id => user.id
      can :show, Response, :user_id => user.id
      cannot :assign_roles, User
      cannot :destroy, User
      cannot :list, :students
    elsif user.role? :advisor
      can [:read, :show, :edit, :update], User, :id => user.id, :roles_mask => user.roles_mask
      cannot :destroy, User, :id => user.id, :roles_mask => user.roles_mask
      can [:read, :show, :edit, :update], User, :roles_mask => 1..2
      can :index, User, :roles_mask => 1..2
      can :list, :students
      can :list, :advisors
      cannot :list, :professors
      cannot :list, :gods
      can :manage, User, :roles_mask => 1..2
      can :create, User
      can :index, Response
      cannot :destroy, User
      cannot :assign_roles, User
    elsif user.role? :professor
      # --------------------------------------------------
      can [:read, :show, :edit, :update], User, :id => user.id, :roles_mask => user.roles_mask
      cannot :destroy, User, :id => user.id, :roles_mask => user.roles_mask
      can [:read, :show, :edit, :update], User, :roles_mask => 1..4
      can :index, User, :roles_mask => 1..4
      can :list, :students
      can :list, :advisors
      can :list, :professors
      cannot :list, :gods
      can :manage, User, :roles_mask => 1..2
      can :create, User
      can :destroy, User, :roles_mask => 1..2
      can :assign_roles, User
      can :manage, Survey
      can :manage, :survey
      can :manage, Response
      # --------------------------------------------------
    elsif user.role? :god
      can :manage, :all
      can :assign_roles, User
      can :list, :students
      can :list, :advisors
      can :list, :professors
      can :list, :gods
      can :manage, Response
    else
      #guest shit
      cannot :manage, :all
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
