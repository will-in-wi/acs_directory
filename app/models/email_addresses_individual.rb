class EmailAddressesIndividual < ApplicationRecord
  belongs_to :email_address
  belongs_to :individual
end
