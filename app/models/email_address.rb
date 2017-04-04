class EmailAddress < ApplicationRecord
  self.primary_key = 'id'

  has_many :individuals, through: :email_addresses_individuals
  has_many :email_addresses_individuals, dependent: :destroy

  validates_uniqueness_of :id
end
