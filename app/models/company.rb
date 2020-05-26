class Company < ApplicationRecord
  ##Associations
  has_many :involved_companies
  has_many :games, through: :involved_companies
  has_many :reviews, as: :reviewable

  ##Validations
  validates :name, :country, presence: true
  validates :name, uniqueness: true
end
