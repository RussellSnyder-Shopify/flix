class GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
    puts @genres.map(&:name)
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to genres_path, notice: 'Genre sucessfully created!'
    else
      render :new
    end
  end

  private

  def genre_params
    params.require(:genre)
          .permit(:name)
  end
end
