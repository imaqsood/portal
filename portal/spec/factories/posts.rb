FactoryBot.define do
  factory :post do
    body { "MyText" }
    state { "MyString" }
    user { nil }
  end
end
