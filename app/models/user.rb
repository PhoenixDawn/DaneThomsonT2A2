class User < ApplicationRecord
  rolify
  acts_as_messageable

  validates :street_number, presence: true
  validates :postcode, presence: true
  validates :suburb, presence: true
  validates :state, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable #, :confirmable
end
