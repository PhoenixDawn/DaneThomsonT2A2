class User < ApplicationRecord
  rolify
  acts_as_messageable

  before_destroy { messages.destroy_all }

  has_many :listings, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :street_number, presence: true
  validates :postcode, presence: true
  validates :suburb, presence: true
  validates :state, presence: true
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable #, :confirmable
end
