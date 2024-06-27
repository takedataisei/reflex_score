FactoryBot.define do
  factory :peer_evaluation do
    score { Faker::Number.between(from: 1, to: 5) }
    comment { Faker::Lorem.sentence }
    association :evaluation_item
    association :evaluator, factory: :user
    association :evaluatee, factory: :user
  end
end