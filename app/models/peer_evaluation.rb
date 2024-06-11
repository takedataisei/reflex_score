class PeerEvaluation < ApplicationRecord
  belongs_to :user
  belongs_to :evaluation_item

  validates :score, presence: true
end
