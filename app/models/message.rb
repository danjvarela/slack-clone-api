class Message < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, polymorphic: true

  validates :body, presence: true
end
