require 'spec_helper'

describe Indexer::Individual do

  before { stub_request(:get, "https://testuser:testpassword@secure.accessacs.com/api_accessacs_mobile/v2/123456/individuals/2").
         to_return(:status => 200, :body => IO.read(Rails.root.join('spec', 'fixtures', 'individuals', 'person1.json')), :headers => { 'Content-Type' => 'application/json; charset=utf-8' }) }

  let(:person1) { ACS::Individual.find(2) }

  describe '#import!' do
    it 'works when entirely new' do
      expect(person1).to_not be_nil
      ind = Indexer::Individual.new(person1)
      ind.import!

      individual = Individual.find(2)
      expect(individual).to_not be_nil
      expect(individual.suffix).to be_nil

      email = individual.email_addresses.find(2)
      expect(email).to_not be_nil
      expect(email.email_type).to eql('Personal')
      expect(email.preferred).to be_true
      expect(email.email_address).to eql('jdoe@example.com')
      expect(email.listed).to be_true

    end

    it 'works when already existing' do
      e = build :person1_email
      e.email_address = 'jdoe1@example.com'
      e.save!

      i = build :person1_individual
      i.suffix = 'Blah'
      i.email_addresses << e

      i.email_addresses.new do |ea|
        # Extra email that should be deleted
        ea.id = 4
        ea.email_type = 'Personal'
        ea.preferred = true
        ea.email_address = 'jdoe3@example.com'
        ea.listed = true
      end

      i.save!

      expect(person1).to_not be_nil
      ind = Indexer::Individual.new(person1)
      ind.import!

      individual = Individual.find(2)
      expect(individual).to_not be_nil
      expect(individual.suffix).to be_nil

      expect(individual.email_addresses).to have(1).item

      email = individual.email_addresses.find(2)
      expect(email).to_not be_nil
      expect(email.email_type).to eql('Personal')
      expect(email.preferred).to be_true
      expect(email.email_address).to eql('jdoe@example.com')
      expect(email.listed).to be_true

      # Create a test later to make sure that all of the unused email addresses are gone.
      # secondary_email = EmailAddress.find_by_id(4)
      # expect(secondary_email).to be_nil
    end
  end
end
