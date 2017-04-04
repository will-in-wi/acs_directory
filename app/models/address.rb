class Address < ApplicationRecord
  self.primary_key = 'id'

  has_many :individuals, through: :addresses_individuals
  has_many :addresses_individuals, dependent: :destroy

  validates_uniqueness_of :id

  scope :personal, -> { where(family_address: false) }
  scope :family, -> { where(family_address: true) }
end
