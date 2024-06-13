class PeerEvaluation < ApplicationRecord
  belongs_to :evaluator, class_name: 'User'
  belongs_to :evaluatee, class_name: 'User'
  belongs_to :evaluation_item

  validates :score, presence: true, inclusion: { in: 1..5, message: "must be between 1 and 5" }
end
