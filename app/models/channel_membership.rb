class ChannelMembership < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  validate :member_cannot_be_added_more_than_once
  validate :channel_creator_cannot_be_member

  private

  def channel_creator_cannot_be_member
    if channel.creator == user
      channel.errors.add(:members, "cannot include the channel's creator")
      errors.add(:user, "cannot be the channel's creator")
    end
  end

  def member_cannot_be_added_more_than_once
    if channel.members.include? user
      channel.errors.add(:members, "cannot be added more than once")
      errors.add(:user, "is already a member")
    end
  end
end
