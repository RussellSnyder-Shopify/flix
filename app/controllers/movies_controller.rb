class MoviesController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]
  before_action :set_movie, only: %i[show edit update destroy]

  def index
    @pagy, @movies = pagy(Movie.send(movies_filter))
  end

  def show
    @favorite = current_user.favorites.find_by(movie_id: @movie.id) if current_user
    @review = Review.new
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to @movie, notice: 'Movie sucessfully created!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie sucessfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, alert: "#{@movie.title} Deleted!"
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end

  def movie_params
    params.require(:movie)
          .permit(:title, :rating, :total_gross, :released_on, :main_image,
                  :description, :director, :duration, genre_ids: [])
  end

  def movies_filter
    if params[:filter].in? Movie::PUBLIC_FILTERS
      params[:filter]
    else
      :released
    end
  end
end
