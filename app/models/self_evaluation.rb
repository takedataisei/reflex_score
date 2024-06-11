class SelfEvaluation < ApplicationRecord
  belongs_to :evaluation_item
  belongs_to :evaluator, class_name: 'User', foreign_key: 'evaluator_id'
  belongs_to :evaluatee, class_name: 'User', foreign_key: 'evaluatee_id'

  validates :score, presence: true
end
