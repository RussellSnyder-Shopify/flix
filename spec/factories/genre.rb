FactoryBot.define do
  factory :genre do
    name { Faker::Lorem.sentence(word_count: 2, supplemental: false, random_words_to_add: 1) }
  end
end
