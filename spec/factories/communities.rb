FactoryBot.define do
  factory :community do
    name { Faker::Company.unique.name }
    password { 'password' }
    password_confirmation { 'password' }
    description { Faker::Lorem.paragraph }
  end
end