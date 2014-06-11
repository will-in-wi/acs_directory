class Address < ActiveRecord::Base
  self.primary_key = 'id'

  has_many :individuals, through: :addresses_individuals
  has_many :addresses_individuals, dependent: :destroy

  validates_uniqueness_of :id
end
