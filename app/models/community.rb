class Community < ApplicationRecord
  has_many :community_memberships, dependent: :destroy
  has_many :users, through: :community_memberships
  has_many :evaluation_items, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  has_secure_password

  private

  def password_required?
    new_record? || !password.nil?
  end
end
