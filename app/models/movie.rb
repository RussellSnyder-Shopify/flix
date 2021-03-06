class Movie < ApplicationRecord
  before_save :set_slug

  RATINGS = %w[G PG PG-13 R NC-17].freeze

  PUBLIC_FILTERS = %w[upcoming recent hitis flops]

  HIT_THRESHOLD = 300_000_000
  FLOP_THRESHOLD = 22_500_000

  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user

  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  has_one_attached :main_image

  validates :released_on, :duration, presence: true
  validates :title, presence: true, uniqueness: true

  validates :description, length: {
    minimum: 25
  }

  validates :total_gross, numericality: { only_interger: true, greater_than_or_equal_to: 0 }

  validate :acceptable_image

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

  def to_param
    title.parameterize
  end

  private

  def acceptable_image
    return unless main_image.attached?

    errors.add(:main_image, 'is too big') unless main_image.blob.byte_size <= 1.megabyte

    acceptable_types = ['image/jpeg', 'image/png']
    errors.add(:main_image, 'must be a jpeg or png') unless acceptable_types.include?(main_image.content_type)
  end

  def set_slug
    self.slug = title.parameterize
  end
end
