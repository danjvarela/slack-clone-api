class Channel < ApplicationRecord
  include Messageable
  belongs_to :creator, class_name: "User"
  has_many :channel_memberships, dependent: :destroy
  has_many :members, through: :channel_memberships, source: :user
  has_many :received_messages, as: :receiver, class_name: "Message"

  validates :name, presence: true, uniqueness: {scope: :creator_id}
end
