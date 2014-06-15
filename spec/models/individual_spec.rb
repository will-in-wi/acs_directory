require 'spec_helper'

describe Individual do
  describe '#spouse' do
    let(:head) do
      Individual.new do |indv|
        indv.id = 1
        indv.family_id = 1001
        indv.last_name = 'Doe'
        indv.first_name = 'John'
        indv.family_position = 'Head'
      end
    end

    let(:spouse) do
      Individual.new do |indv|
        indv.id = 2
        indv.family_id = 1001
        indv.last_name = 'Doe'
        indv.first_name = 'Jane'
        indv.family_position = 'Spouse'
      end
    end

    it 'returns the spouse if given a head' do
      spouse.save!
      head.save!

      expect(head.spouse).to eql(spouse)
    end

    it 'returns the head if given a spouse' do
      spouse.save!
      head.save!

      expect(spouse.spouse).to eql(head)
    end

    it 'returns nil if no spouse' do
      head.save!

      expect(head.spouse).to be_nil
    end

    it 'returns nil if not a head or spouse' do
      head.family_position = 'Child'
      head.save!

      spouse.save!

      expect(head.spouse).to be_nil
    end
  end
end
