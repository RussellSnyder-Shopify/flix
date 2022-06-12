FactoryBot.define do
  factory :movie do
    title { Faker::Movie.unique.title }
    rating { Movie::RATINGS.sample }
    director { 'Test Movie Director' }
    duration { '6 Hours 30 Minutes' }
    total_gross { 20_000_000 }
    created_at { '1995-09-23' }
    updated_at { '1995-09-23' }
    description { "lovely movie really, couldn't stop watching lalalalallalala " }
    released_on { '1995-09-23' }
  end
  #   default_date = Faker::Date.between(from: '1995-09-23', to: '2020-09-25')

  #   factory :movie do
  #     title { Faker::Movie.unique.title }
  #     rating { Movie::RATINGS.sample }
  #     director { Faker::Name.name }
  #     duration { "#{Faker::Number.between(from: 1, to: 2)} Hours and #{Faker::Number.between(from: 0, to: 59)} Minutes" }
  #     total_gross { Faker::Number.normal(mean: 250_000_000, standard_deviation: 1_000_000) }
  #     created_at { default_date }
  #     updated_at { default_date }
  #     description do
  #       "#{Faker::Movie.quote} #{Faker::Lorem.sentence(word_count: 30,
  #                                                      supplemental: false, random_words_to_add: 20)}"
  #     end
  #     released_on { Faker::Date.between(from: '1995-09-23', to: '2030-09-25') }
  #   end
end
