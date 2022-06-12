FactoryBot.define do
  factory :movie do
    title { Faker::Lorem.sentence(word_count: 5, supplemental: false, random_words_to_add: 4) }
    rating { Movie::RATINGS.sample }
    director { 'Test Movie Director' }
    duration { '6 Hours 30 Minutes' }
    total_gross do
      Faker::Number.normal(mean: (Movie::HIT_THRESHOLD + Movie::FLOP_THRESHOLD) / 2, standard_deviation: 5_000_000)
    end
    description { "lovely movie really, couldn't stop watching lalalalallalala " }
    released_on { Faker::Date.between(from: '1995-09-23', to: '2030-09-25') }

    factory :upcoming_movie do
      title { Faker::Movie.unique.title }
      released_on { Faker::Date.between(from: 1.year.from_now, to: 10.years.from_now) }
    end

    factory :flop_movie do
      total_gross { Movie::FLOP_THRESHOLD - Faker::Number.between(from: 1, to: 100_000) }
    end
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
