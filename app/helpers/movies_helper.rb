module MoviesHelper
  def total_gross(movie)
    if movie.flop?
      'Flop!'
    else
      number_to_currency(movie.total_gross, precision: 0)
    end
  end

  def year_of(movie)
    movie.released_on.year
  end

  def average_stars(movie)
    if movie.average_stars == 0.0
      content_tag('strong', 'No Reviews')
    else
      ActionController::Base.helpers.pluralize(movie.average_stars.round(1).to_f, 'star')
    end
  end

  def nav_link_to(text, url)
    if current_page?(url)

      link_to(text, url, class: 'text-blue-600')
    else
      link_to(text, url)

    end
  end

  def main_image(movie)
    url = if movie.main_image.attached?
            movie.main_image.variant(resize_to_limit: [100, 100],
                                     monochrome: true)
          else
            'placeholder.png'
          end
    image_tag(url, class: "self-center object-cover w-auto
      h-15", alt: 'Flix Logo')
  end
end
