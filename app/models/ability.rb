class Ability
  include CanCan::Ability

  def initialize(user)
    # Don't access anything if not logged in
    return unless user.present?

    # Logged in user can create channels and messages
    can :create, [Channel, Message]

    # Logged in user can read channel if it is a member
    can :read, Channel, {members: {id: user.id}}

    # Logged in user can read messages if it is the sender or receiver
    can :read, Message do |message|
      message.receiver == user || message.sender == user
    end

    # Channel can only be managed by the logged in user if it is the creator
    can :manage, Channel, creator: user

    # Message can only be managed by the logged in user if it is the sender
    can :manage, Message, sender: user

    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
