class Listing < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  has_many :orders

  validates :photo, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :ingredients, presence: true

  def return_price
    return (self.price.to_f * 100).to_i
  end
end
