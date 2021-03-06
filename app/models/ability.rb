class Ability
  include CanCan::Ability

  # Define abilities for the passed in user in the `initialize` method. For example:
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

  def initialize(user)
    can :read, :all # allow everyone to read everything

    if user
      can :create, Post
      can :manage, Post, :user_id => user.id

      if user.admin?
        can :access, :rails_admin
        can :dashboard
        can :manage, :all
      end
    end
  end
end
