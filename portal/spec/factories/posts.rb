FactoryBot.define do
  factory :post do
    body { Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 2) }
    state { 'Initial' }
    association :user, factory: [:user, :confirmed]
  end
end
