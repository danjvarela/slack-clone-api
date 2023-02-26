class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  include Messageable

  has_many :created_channels, class_name: "Channel", foreign_key: :creator_id
  has_many :channel_memberships
  has_many :joined_channels, through: :channel_memberships, source: :channel
  has_many :sent_messages, class_name: "Message", foreign_key: :sender_id
  has_many :received_messages, as: :receiver, class_name: "Message"
end
