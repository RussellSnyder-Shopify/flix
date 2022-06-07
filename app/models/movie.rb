class Movie < ApplicationRecord
  RATINGS = %w[G PG PG-13 R NC-17].freeze

  PUBLIC_FILTERS = %w[upcoming recent hitis flops]

  HIT_THRESHOLD = 300_000_000
  FLOP_THRESHOLD = 22_500_000

  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user

  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

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
    total_gross.blank? || total_gross < FLOP_THRESHOLD
  end

  def score
    stars = reviews.collect(&:stars)
    (stars.sum.to_f / stars.count.to_f).round(2)
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (average_stars / 5.0) * 100
  end

  scope :upcoming, lambda {
    where('released_on > ?', Time.now).order('released_on asc')
  }

  scope :released, lambda {
    where('released_on < ?', Time.now).order('released_on desc')
  }

  scope :recent, lambda { |max = 5|
    released.limit(max)
  }

  scope :hits, lambda {
    released.where('total_gross > ?', FLOP_THRESHOLD).order(total_gross: :desc)
  }

  scope :flops, lambda {
    released.where('total_gross < ?', FLOP_THRESHOLD).order(total_gross: :asc)
  }
end
