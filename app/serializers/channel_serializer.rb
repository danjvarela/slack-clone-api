class ChannelSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at

  has_many :members
  has_many :received_messages
  has_one :creator
end
