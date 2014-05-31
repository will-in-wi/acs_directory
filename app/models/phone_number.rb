class PhoneNumber < ActiveRecord::Base
  self.primary_key = 'id'

  validates_uniqueness_of :id
end
