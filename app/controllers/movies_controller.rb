class MoviesController < ApplicationController
    def index
        @movies = %w{Iron Man Superman Spider-Man}
    end
end
