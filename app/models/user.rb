# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :created_channels, class_name: "Channel", foreign_key: :creator_id
  has_many :channel_memberships
  has_many :joined_channels, through: :channel_memberships, source: :channel
end
