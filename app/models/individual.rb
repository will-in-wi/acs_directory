class Individual < ActiveRecord::Base
  self.primary_key = 'id'

  has_many :email_addresses, through: :email_addresses_individuals
  has_many :email_addresses_individuals

  has_many :addresses, through: :addresses_individuals
  has_many :addresses_individuals

  validates_uniqueness_of :id
end
