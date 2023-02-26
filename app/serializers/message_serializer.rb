class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :receiver_type

  has_one :sender
  has_one :receiver
end
