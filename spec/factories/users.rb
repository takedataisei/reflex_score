FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }
    username { Faker::Internet.username }
    profile { Faker::Lorem.paragraph }
    
    trait :with_image do
      after(:build) do |user|
        user.image.attach(io: File.open(Rails.root.join('public/images/test_image.png')), filename: 'test_image.png')
      end
    end
  end
end