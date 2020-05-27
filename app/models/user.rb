class User < ApplicationRecord
  require 'time_difference'
  ##Associations
  has_many :reviews

  ##Validations
  validates :username, :email, presence: true, uniqueness: true
  validate :valid_birth_date

  ##use bcrypt (columna password_digest required)
  has_secure_password

  ##Custom Validations
  private
  def valid_birth_date
    if birth_date.present? && TimeDifference.between(birth_date, DateTime.now).in_years < 16
      errors.add(:birth_date, "You should be 16 years old to create an account")
    end
  end
end
