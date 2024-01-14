class User < ApplicationRecord
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 5, maximum: 50}
  validates :name, presence: true, length: { minimum: 2, maximum: 50}
  validates :surname, presence: true, length: { minimum: 2, maximum: 50}
  has_many :vehicles
end
