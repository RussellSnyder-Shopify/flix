# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..30).each do |id|
  rating = id.even? ? 'PG' : 'PG 13'
  rating = id % 5 == 0 ? 'R' : rating
  rating = id % 7 == 0 ? 'G' : rating

  default_date = Faker::Date.between(from: '1995-09-23', to: '2020-09-25')

  Movie.create!(
    title: Faker::Movie.unique.title,
    rating: rating,
    director: Faker::Name.name,
    duration: "#{Faker::Number.between(from: 1, to: 2)} Hours and #{Faker::Number.between(from: 0, to: 59)} Minutes",
    total_gross: Faker::Number.normal(mean: 250_000_000, standard_deviation: 1_000_000),
    created_at: default_date,
    updated_at: default_date,
    description: "#{Faker::Movie.quote} #{Faker::Lorem.sentence(word_count: 30,
                                                                supplemental: false, random_words_to_add: 20)}",
    released_on: Faker::Date.between(from: '1995-09-23', to: '2030-09-25')
  )

  image_file_name = "cat#{Faker::Number.between(from: 1, to: 4)}.jpeg"
  image = File.open(Rails.root.join("app/assets/images/#{image_file_name}"))
  puts "Attaching image #{image_file_name} to movie"

  Movie.find(id).main_image.attach(io: image, filename: image_file_name)
end

(1..10).each do |_i|
  genre = Faker::Book.genre

  next if Genre.find_by(name: genre)

  Genre.create!(
    name: genre
  )
end

(1..10).each do |i|
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.email,
    password: 'passwordpassword',
    role: User::ROLES[Faker::Number.between(from: 0, to: User::ROLES.size - 1)],
    username: i.even? ? 'username is here' : nil
  )
end

movies = Movie.all
genres = Genre.all
users = User.all

movies.each do |movie|
  genre_ids = Set[]

  Array.new(Faker::Number.between(from: 1, to: genres.size)).each do |_i|
    genre_ids.add(Faker::Number.between(from: 1, to: genres.size))
  end

  movie.genre_ids = genre_ids
end

users.each do |user|
  favorite_movies = Set[]

  Array.new(Faker::Number.between(from: 1, to: movies.size)).each do |_i|
    favorite_movies.add(Movie.find(Faker::Number.between(from: 1, to: movies.size)))
  end

  user.favorite_movies = favorite_movies

  Array.new(Faker::Number.between(from: 1, to: 10)).each do |_i|
    Review.create!(
      user: user,
      stars: Faker::Number.between(from: 0, to: 5),
      comment: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 5)),
      movie_id: Faker::Number.between(from: 1, to: movies.size)
    )
  end
end
