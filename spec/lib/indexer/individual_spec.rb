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

      expect(individual.email_addresses).to have(1).item

      email = individual.email_addresses.find(2)
      expect(email).to_not be_nil
      expect(email.email_type).to eql('Personal')
      expect(email.preferred).to be_true
      expect(email.email_address).to eql('jdoe@example.com')
      expect(email.listed).to be_true

      expect(individual.addresses).to have(1).item

      address = individual.addresses.find(3)
      expect(address.address_type_id).to eql(4)
      expect(address.address_type).to eql('Home')
      expect(address.family_address).to be_true
      expect(address.active).to be_true
      expect(address.mailing_address).to be_true
      expect(address.statement_address).to be_true
      expect(address.country).to eql('USA')
      expect(address.company).to be_nil
      expect(address.address).to eql('123 Sesame Street')
      expect(address.address2).to be_nil
      expect(address.city).to eql('Metroville')
      expect(address.state).to eql('MN')
      expect(address.zip_code).to eql('12345-1234')
    end

    it 'works when already existing' do
      e = build :person1_email
      e.email_address = 'jdoe1@example.com'
      e.save!

      a = build :person1_address
      a.address = '321 blah St.'
      a.save!

      i = build :person1_individual
      i.suffix = 'Blah'
      i.email_addresses << e
      i.addresses << a

      i.email_addresses.new do |ea|
        # Extra email that should be deleted
        ea.id = 4
        ea.email_type = 'Personal'
        ea.preferred = true
        ea.email_address = 'jdoe3@example.com'
        ea.listed = true
      end

      i.addresses.new do |addr|
        # Extra email that should be deleted
        addr.id = 5
        addr.address_type_id = 4
        addr.address_type = 'Home'
        addr.family_address = true
        addr.active = true
        addr.mailing_address = true
        addr.statement_address = true
        addr.country = 'USA'
        addr.company = nil
        addr.address = '123 Blah Street'
        addr.address2 = nil
        addr.city = 'Metroville'
        addr.state = 'MN'
        addr.zip_code = '12345-1234'
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

      expect(individual.addresses).to have(1).item

      address = individual.addresses.find(3)
      expect(address.address_type_id).to eql(4)
      expect(address.address_type).to eql('Home')
      expect(address.family_address).to be_true
      expect(address.active).to be_true
      expect(address.mailing_address).to be_true
      expect(address.statement_address).to be_true
      expect(address.country).to eql('USA')
      expect(address.company).to be_nil
      expect(address.address).to eql('123 Sesame Street')
      expect(address.address2).to be_nil
      expect(address.city).to eql('Metroville')
      expect(address.state).to eql('MN')
      expect(address.zip_code).to eql('12345-1234')

      # Create a test later to make sure that all of the unused email addresses are gone.
      # secondary_email = EmailAddress.find_by_id(4)
      # expect(secondary_email).to be_nil
    end
  end
end
