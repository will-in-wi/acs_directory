require 'spec_helper'

describe Individual, :type => :model do
  describe '#spouse' do
    it 'returns the spouse if given a head' do
      spouse = create :individual_spouse
      head = create :individual_head

      expect(head.spouse).to eql(spouse)
    end

    it 'returns the head if given a spouse' do
      spouse = create :individual_spouse
      head = create :individual_head

      expect(spouse.spouse).to eql(head)
    end

    it 'returns nil if no spouse' do
      head = create :individual_head

      expect(head.spouse).to be_nil
    end

    it 'returns nil if not a head or spouse' do
      head = build :individual_head
      head.family_position = 'Child'
      head.save!

      expect(head.spouse).to be_nil
    end
  end
end
