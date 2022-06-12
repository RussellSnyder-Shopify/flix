movies = FactoryBot.build_list(:movie, 30)
movies.each(&:save!)

genres = FactoryBot.build_list(:genre, 10)
genres.each(&:save!)

users = FactoryBot.build_list(:user, 10)
users.each(&:save!)

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

  reviews = FactoryBot.build_list(:review, Faker::Number.between(from: 1, to: 10))
  reviews.each(&:save!)
end
