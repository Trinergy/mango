class User < ActiveRecord::Base
  paginates_per 10

  has_many :reviews, dependent: :destroy

  has_secure_password

  validates :email,
    presence: true

  validates :firstname,
    presence: true

  validates :lastname,
    presence: true

  validates :password,
    length: { in: 6..20 }, on: :create

  def full_name
    "#{firstname} #{lastname}"
  end

  # def admin=(value)
  #   if value == '1'
  #     true
  #   elsif value == '0'
  #     false
  #   else
  #     value
  #   end
  # end

end
