FactoryBot.define do
  factory :community_membership do
    association :user
    association :community
    role { :member }
  end
end