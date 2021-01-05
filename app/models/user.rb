class User < ApplicationRecord
  has_secure_password

  has_many :group_user, dependent: :restrict_with_error
  has_many :groups, through: :group_user

  validates :username, presence: true,
    format: {with: /\A[a-z0-9_-]{2,16}\z/i},
    uniqueness: {case_sensitive: false}

  validates :email, presence: true,
    format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,64})\z/i},
    uniqueness: {case_sensitive: false}
end
