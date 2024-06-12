class SelfEvaluation < ApplicationRecord
  belongs_to :evaluation_item
  belongs_to :user
  
  validates :score, presence: true, inclusion: { in: 1..5, message: "must be between 1 and 5" }
end
