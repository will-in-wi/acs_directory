class Individual < ApplicationRecord
  self.primary_key = 'id'

  has_many :email_addresses, through: :email_addresses_individuals
  has_many :email_addresses_individuals, dependent: :destroy

  has_many :addresses, through: :addresses_individuals
  has_many :addresses_individuals, dependent: :destroy

  has_many :phone_numbers, through: :individuals_phone_numbers
  has_many :individuals_phone_numbers, dependent: :destroy

  validates_uniqueness_of :id

  validates_presence_of :id

  def spouse
    if self.family_position == 'Head'
      Individual.where(family_id: self.family_id, family_position: 'Spouse').first
    elsif self.family_position == 'Spouse'
      Individual.where(family_id: self.family_id, family_position: 'Head').first
    end
  end

end
