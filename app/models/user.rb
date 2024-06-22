class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  has_many :community_memberships, dependent: :destroy
  has_many :communities, through: :community_memberships
  has_many :self_evaluations, dependent: :destroy
  has_many :evaluations_given, class_name: 'PeerEvaluation', foreign_key: 'evaluator_id', dependent: :destroy
  has_many :evaluations_received, class_name: 'PeerEvaluation', foreign_key: 'evaluatee_id', dependent: :destroy
  has_many :messages, dependent: :destroy
  
  validates :username, presence: true

  def image_url
    if image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
    else
      ActionController::Base.helpers.asset_path('no_image.png')
    end
  end
end
