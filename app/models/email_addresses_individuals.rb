class EmailAddressesIndividuals < ActiveRecord::Base
  belongs_to :email_address
  belongs_to :individual
end
