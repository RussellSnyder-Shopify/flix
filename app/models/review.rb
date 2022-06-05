class Review < ApplicationRecord
  STARS = [0, 1, 2, 3, 4, 5].freeze

  belongs_to :movie

  validates :name, :comment, presence: true

  validates :stars, inclusion: { in: STARS }

  validates :comment, length: {
    maximum: 500
  }

  def stars_as_percent
    (stars / 5.0) * 100.0
  end
end
