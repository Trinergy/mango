class Movie < ActiveRecord::Base
  paginates_per 10

  mount_uploader :image, ImageUploader

  scope :search, ->(query) { where('title LIKE ? OR director LIKE ?', "%#{query}%", "%#{query}%" ) }
  scope :under_90_minutes, -> { where('runtime_in_minutes < 90') }
  scope :between_90_and_120_minutes, -> { where('runtime_in_minutes >= 90 AND runtime_in_minutes <= 120') }
  scope :over_120_minutes, -> { where('runtime_in_minutes > 120') }

  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  # validates :poster_image_url,
  #   presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size unless reviews.size == 0
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
