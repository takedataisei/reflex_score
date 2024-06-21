class EvaluationItem < ApplicationRecord
  validates :name, presence: true

  belongs_to :community
  has_many :self_evaluations, dependent: :destroy
  has_many :peer_evaluations, dependent: :destroy
end
