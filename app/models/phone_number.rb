class PhoneNumber < ActiveRecord::Base
  self.primary_key = 'id'

  has_many :individuals, through: :individuals_phone_numbers
  has_many :individuals_phone_numbers, dependent: :destroy

  validates_uniqueness_of :id
end
