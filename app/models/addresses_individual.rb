class AddressesIndividual < ActiveRecord::Base
  belongs_to :address
  belongs_to :individual
end