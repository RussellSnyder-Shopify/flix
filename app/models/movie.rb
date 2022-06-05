class Movie < ApplicationRecord
  RATINGS = %w[G PG PG-13 R NC-17].freeze

  has_many :reviews, dependent: :destroy

  validates :title, :released_on, :duration, presence: true

  validates :description, length: {
    minimum: 25
  }

  validates :total_gross, numericality: { only_interger: true, greater_than_or_equal_to: 0 }

  validates :image_file_name, format: {
    with: /\w+\.(jpg|jpeg|png)\z/i,
    message: 'must be a JPG or PNG image'
  }

  def flop?
    total_gross.blank? || total_gross < 225_000_000
  end

  def score
    stars = reviews.collect(&:stars)
    (stars.sum.to_f / stars.count.to_f).round(2)
  end

  def self.released
    where('released_on < ?', Time.now).order('released_on desc')
  end
end
