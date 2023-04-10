class User < ApplicationRecord
  has_secure_token :auth_token

  has_many :sleep_records, dependent: :destroy
end
