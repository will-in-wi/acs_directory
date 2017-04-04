class IndividualsPhoneNumber < ApplicationRecord
  belongs_to :individual
  belongs_to :phone_number
end
