class CommunityMembership < ApplicationRecord
  belongs_to :user
  belongs_to :community

  enum role: { member: 0, admin: 1 }
  validates :role, presence: true
end
