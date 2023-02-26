class Message < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, polymorphic: true

  validates :body, presence: true
  validate :cannot_send_to_channel_not_created_or_joined

  private

  def cannot_send_to_channel_not_created_or_joined
    if receiver_type == "Channel" && !receiver.members.include?(sender) && receiver.creator != sender
      errors.add(:receiver, "is not invalid")
    end
  end
end
