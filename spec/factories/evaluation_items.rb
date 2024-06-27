FactoryBot.define do
  factory :evaluation_item do
    name { Faker::Lorem.word }
    association :community
  end
end