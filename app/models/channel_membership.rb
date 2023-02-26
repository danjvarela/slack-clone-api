class ChannelMembership < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  validate :channel_creator_cannot_be_member

  private

  def channel_creator_cannot_be_member
    if channel.creator == user
      channel.errors.add(:members, "cannot include the channel's creator")
      errors.add(:user, "cannot be the channel's creator")
    end
  end
end
