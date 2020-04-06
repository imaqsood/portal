FactoryBot.define do
  factory :recipe do
    name { "MyString" }
    ingredients { "MyText" }
    instruction { "MyText" }
    image { "MyString" }
  end
end
