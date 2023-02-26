class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :nickname, :image

  has_many :sent_messages
  has_many :received_messages
  has_many :created_channels
  has_many :joined_channels
end
