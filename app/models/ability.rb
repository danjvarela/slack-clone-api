class Ability
  include CanCan::Ability

  def initialize(user)
    # Don't access anything if not logged in
    return unless user.present?

    # Logged in user can create channels
    can :create, Channel

    # Logged in user can read channel if it is a member
    can :read, Channel do |channel|
      channel.members.include? user
    end

    # Logged in user can read messages if it is the sender or receiver
    can :read, Message, receiver: user
    can :read, Message, sender: user

    # Logged in user can read and create messages from a channel it has joined or created
    can [:read, :create], Message do |message|
      message.receiver_type == "Channel" && (message.receiver.members.include?(user) || message.receiver.creator == user)
    end

    # Logged in user can send messages to any other user
    can :create, Message do |message|
      message.receiver_type == "User"
    end

    # Channel can only be managed by the logged in user if it is the creator
    can :manage, Channel, creator: user

    # Message can only be managed by the logged in user if it is the sender
    can [:destroy, :update], Message, sender: user

    # Logged in user can only manage channel memberships if it is the creator
    can :manage, ChannelMembership do |channel_membership|
      channel_membership.channel.creator == user
    end

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
