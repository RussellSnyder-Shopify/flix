module FavoritesHelper
  def like_of_unlike_button(movie, favorite)
    if @favorite
      button_to '♡ unfavorite', movie_favorite_path(movie, favorite),
                method: :delete
    else
      button_to '♥ favorite', movie_favorites_path(movie)
    end
  end
end
