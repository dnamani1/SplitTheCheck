class Restaurant < ApplicationRecord
  validates :name, :address, :city, :state, :zip, presence: true
end
