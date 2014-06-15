require 'spec_helper'

describe Family do
  describe '#name' do
    it 'condenses both names when surnames are the same' do
      create :individual_spouse
      create :individual_head

      family = Family.new(1001)

      expect(family.name).to eql('John and Jane Doe')
    end

    it 'splits out names when surnames are different' do
      spouse = build :individual_spouse
      spouse.last_name = 'Bar'
      spouse.save!
      create :individual_head

      family = Family.new(1001)

      expect(family.name).to eql('John Doe and Jane Bar')
    end

    it 'shows one name when no spouse' do
      create :individual_head

      family = Family.new(1001)

      expect(family.name).to eql('John Doe')
    end
  end
end
