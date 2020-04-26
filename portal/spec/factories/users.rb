FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email }
    password   { Faker::Internet.password }

    trait :confirmed do
      before :create do |user|
        user.skip_confirmation!
        user.skip_confirmation_notification!
      end
    end
  end
end
