class SelfEvaluation < ApplicationRecord
  belongs_to :evaluation_item
  belongs_to :evaluator, class_name: 'User'
  belongs_to :evaluatee, class_name: 'User'
  validates :score, presence: true
end
