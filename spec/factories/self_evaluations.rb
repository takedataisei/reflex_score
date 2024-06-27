FactoryBot.define do
  factory :self_evaluation do
    score { Faker::Number.between(from: 1, to: 5) }
    comment { Faker::Lorem.sentence }
    association :evaluation_item
    association :user
  end
end