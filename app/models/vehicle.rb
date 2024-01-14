class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :fines
end
