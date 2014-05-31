class Individual < ActiveRecord::Base
  self.primary_key = 'id'

  has_many :email_addresses, through: :email_addresses_individuals
  has_many :email_addresses_individuals

  has_many :addresses, through: :addresses_individuals
  has_many :addresses_individuals

  has_many :phone_numbers, through: :individuals_phone_numbers
  has_many :individuals_phone_numbers

  validates_uniqueness_of :id
end
