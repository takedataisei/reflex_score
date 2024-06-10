class EvaluationItem < ApplicationRecord
  validates :name, presence: true

  belongs_to :community
end
