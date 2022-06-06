class User < ApplicationRecord
  has_many :reviews, dependent: :destroy

  has_secure_password

  ROLES = %w[User Admin SuperAdmin].freeze

  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: {
    case_sensitive: false
  }

  validates :password, length: { minimum: 10, allow_blank: true }
  validates :role, inclusion: { in: ROLES }

  def admin?
    role == 'Admin' || role == 'SuperAdmin'
  end

  def super_admin?
    role == 'SuperAdmin'
  end
end
