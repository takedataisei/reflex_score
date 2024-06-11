class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  has_many :community_memberships
  has_many :communities, through: :community_memberships
  has_many :self_evaluations
  has_many :peer_evaluations

  validates :username, presence: true
end
