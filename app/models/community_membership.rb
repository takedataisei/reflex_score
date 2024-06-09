class CommunityMembership < ApplicationRecord
  belongs_to :user
  belongs_to :community

  enum role: { admin: 0, member: 1 }
  validates :role, presence: true
end
