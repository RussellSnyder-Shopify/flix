class GenresController < ApplicationController
  before_action :require_signin, except: %i[show]
  before_action :require_admin, except: %i[show]

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

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])

    if @genre.update(genre_params)
      redirect_to genres_path, notice: 'Genre updated created!'
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])

    @genre.destroy
    redirect_to genres_path(@movie), alert: 'Genre Deleted!'
  end

  private

  def genre_params
    params.require(:genre)
          .permit(:name)
  end
end
