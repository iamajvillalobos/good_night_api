class User < ApplicationRecord
  has_secure_token :auth_token

  has_many :sleep_records, dependent: :destroy

  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followees, through: :follows
  has_many :reverse_follows, class_name: "Follow", foreign_key: :followee_id, dependent: :destroy
  has_many :followers, through: :reverse_follows
end
