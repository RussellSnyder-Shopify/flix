FactoryBot.define do
  factory :review do
    association :user
    association :movie
    stars { Faker::Number.between(from: 0, to: 5) }
    comment { Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 5)) }
  end
end
