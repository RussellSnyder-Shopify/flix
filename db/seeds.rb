# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..30).each do |id|
  rating = id % 3 == 0 ? 'PG' : 'PG 13'

  default_date = Faker::Date.between(from: '1995-09-23', to: '2020-09-25')

  Movie.create!(
    id: id,
    title: Faker::Movie.title,
    rating: rating,
    total_gross: Faker::Number.normal(mean: 250_000_000, standard_deviation: 100_000_000),
    created_at: default_date,
    updated_at: default_date,
    description: "#{Faker::Movie.quote} #{Faker::Lorem.sentence(word_count: 30, supplemental: false,
                                                                random_words_to_add: 20)}",
    released_on: Faker::Date.between(from: '1995-09-23', to: '2030-09-25')
  )
end
