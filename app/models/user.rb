class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password_confirmation, presence: true

  has_many :votes
  has_many :comments, dependent: :destroy
  has_many :favorites
  has_many :favorite_restaurants, through: :favorites, source: :restaurant

  def favorite_restaurants
    favorites.includes(:restaurant).map(&:restaurant)
  end

end
