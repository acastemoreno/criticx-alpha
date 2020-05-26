class InvolvedCompany < ApplicationRecord
  ##Association
  belongs_to :company
  belongs_to :game

  ##Validation
  validates :developer, :publisher, presence: true
end
