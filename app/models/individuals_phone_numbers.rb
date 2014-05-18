class IndividualsPhoneNumbers < ActiveRecord::Base
  belongs_to :individual
  belongs_to :phone_number
end
