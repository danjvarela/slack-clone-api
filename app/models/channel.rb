class Channel < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :channel_memberships
  has_many :members, through: :channel_memberships, source: :user

  validates :name, presence: true, uniqueness: {scope: :creator_id}
end
