require 'spec_helper'

describe Family, :type => :model do
  describe '.all' do
    it 'returns all families without duplicates' do
      create :individual_spouse
      create :individual_head

      families = Family.all
      expect(families.size).to eq(1)

      expect(families.first.id).to eql(1001)
      expect(families.first.picture_url).to eql('http://example.com/picture.jpg')
    end
  end

  describe '#children' do
    it 'returns all children' do
      create :individual_spouse
      create :individual_head
      child1 = create :individual_child
      child2 = create :individual_child

      family = Family.new(1001)

      expect(family.children.size).to eql(2)
      expect(family.children[0]).to eql(child1)
      expect(family.children[1]).to eql(child2)
    end

    it 'returns empty array if no children' do
      create :individual_spouse
      create :individual_head

      family = Family.new(1001)

      expect(family.children).to_not be_any
    end
  end

  describe '#spouse' do
    it 'returns spouse' do
      spouse = create :individual_spouse
      create :individual_head

      family = Family.new(1001)

      expect(family.spouse).to eql(spouse)
    end

    it 'returns nil if no spouse' do
      create :individual_head

      family = Family.new(1001)

      expect(family.spouse).to be_nil
    end
  end

  describe '#head' do
    it 'returns head' do
      create :individual_spouse
      head = create :individual_head

      family = Family.new(1001)

      expect(family.head).to eql(head)
    end

    it 'returns nil if no head' do
      # I do not see how this could be the case. But let's handle it anyway.
      create :individual_spouse

      family = Family.new(1001)

      expect(family.head).to be_nil
    end
  end

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

    it 'shows one name when no head' do
      # This usually indicates a situation which should be fixed.
      create :individual_spouse

      family = Family.new(1001)

      expect(family.name).to eql('Jane Doe')
    end
  end
end
