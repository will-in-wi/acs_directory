module Indexer
  class Individual

    def self.import_all!(individuals)
      individuals.each do |i|
        indv = self.new(i)
        # TODO: Log instead of puts.
        begin
          indv.import!
          puts "Successfully imported ##{i.indv_id}"
        rescue => e
          puts "Failed to import ##{i.indv_id}. Error: #{e.message}"
        end
      end

      # TODO: Clear out all phone numbers, addresses, and email addresses that are not associated with an individual.
    end

    def initialize(individual)
      @individual = individual
    end

    def import!
      # Import person
      individual = import_individual

      # Check email
      import_email_addresses(individual)

      # Check addresses
      import_addresses(individual)

      # Check phone numbers
      import_phone_numbers(individual)
    end

    protected

      def import_individual
        individual = ::Individual.find_by_id(@individual.indv_id)
        if individual.nil?
          individual = ::Individual.new do |ea|
            ea.id = @individual.indv_id
          end
        end
        individual.family_id = @individual.prim_family
        individual.first_name = @individual.first_name
        individual.middle_name = @individual.middle_name
        individual.last_name = @individual.last_name
        individual.goes_by_name = @individual.goes_by_name
        individual.title = @individual.title
        individual.picture_url = @individual.picture_url
        individual.family_position = @individual.family_position
        individual.suffix = @individual.suffix
        individual.full_name = @individual.full_name
        individual.friendly_name = @individual.friendly_name
        individual.family_picture_url = @individual.family_picture_url
        individual.date_of_birth = Date.strptime(@individual.date_of_birth, "%m/%d/%Y")
        individual.member_status = @individual.member_status
        individual.save

        individual
      end

      def import_email_addresses(individual)
        @individual.emails.each do |e|
          email = EmailAddress.find_by_id(e.email_id)
          if email.nil?
            # Insert new email into DB.
            email = EmailAddress.new do |ea|
              ea.id = e.email_id
            end
          end

          email.listed = e.listed
          email.preferred = e.preferred
          email.email_type = e.email_type
          email.email_address = e.email
          email.save

          EmailAddressesIndividual.find_or_create_by(email_address: email, individual: individual)
        end

        # Remove email addresses that are no longer used.
        # Reload email addresses from database since there is an out of date cache.
        removed_email_ids = individual.email_addresses(true).map(&:id) - @individual.emails.map {|e| e['email_id']}
        individual.email_addresses_individuals.where(email_address_id: removed_email_ids).destroy_all
      end

      def import_addresses(individual)
        @individual.addresses.each do |a|
          address = Address.find_by_id(a.addr_id)
          if address.nil?
            # Insert new address into DB.
            address = Address.new do |addr|
              addr.id = a.addr_id
            end
          end

          address.address_type = a.addr_type
          address.mailing_address = a.mail_address
          address.address = a.address
          address.address2 = a.address2
          address.city = a.city
          address.state = a.state
          address.zip_code = a.zipcode
          address.country = a.country
          address.latitude = a.latitude
          address.longitude = a.longitude
          address.active = a.active_address
          address.family_address = a.family_address
          address.company = a.company
          address.statement_address = a.statement_address
          address.address_type_id = a.addr_type_id
          address.save

          AddressesIndividual.find_or_create_by(address: address, individual: individual)
        end

        # Remove addresses that are no longer used.
        # Reload addresses from database since there is an out of date cache.
        removed_addr_ids = individual.addresses(true).map(&:id) - @individual.addresses.map {|e| e['addr_id']}
        individual.addresses_individuals.where(address_id: removed_addr_ids).destroy_all
      end

      def import_phone_numbers(individual)
        @individual.phones.each do |p|
          phone = PhoneNumber.find_by_id(p.phone_id)
          if phone.nil?
            # Insert new phone into DB.
            phone = PhoneNumber.new do |phn|
              phn.id = p.phone_id
            end
          end

          phone.preferred = p.preferred
          phone.phone_type_id = p.phone_type_id
          phone.phone_type = p.phone_type
          phone.family_phone = p.family_phone
          phone.phone_number = p.phone_number
          phone.extension = p.extension
          phone.listed = p.listed
          phone.address_phone = p.addr_phone
          phone.phone_ref = p.phone_ref
          phone.save

          IndividualsPhoneNumber.find_or_create_by(phone_number: phone, individual: individual)
        end

        # Remove phones that are no longer used.
        # Reload phones from database since there is an out of date cache.
        removed_phone_ids = individual.phone_numbers(true).map(&:id) - @individual.phones.map {|e| e['phone_id']}
        individual.individuals_phone_numbers.where(phone_number_id: removed_phone_ids).destroy_all
      end

  end
end
