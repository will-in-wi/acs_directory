class PhoneNumber < ApplicationRecord
  self.primary_key = 'id'

  has_many :individuals, through: :individuals_phone_numbers
  has_many :individuals_phone_numbers, dependent: :destroy

  validates_uniqueness_of :id

  scope :personal, -> { where(family_phone: false, listed: true) }
  scope :family, -> { where(family_phone: true, listed: true) }
end
