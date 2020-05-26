class InvolvedCompany < ApplicationRecord
  ##Association
  belongs_to :company
  belongs_to :game

  ##Validation
  validates :developer, :publisher, inclusion: [true, false]
end
