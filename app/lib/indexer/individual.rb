module Indexer
  class Individual

    def initialize(individual)
      @individual = individual
    end

    def import!
      # Import person
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

      # Check email
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
      # Reload individual from database since there is an out of date cache.
      removed_email_ids = individual.email_addresses(true).map(&:id) - @individual.emails.map {|e| e['email_id']}
      individual.email_addresses_individuals.where(email_address_id: removed_email_ids).destroy_all

      # TODO: Check addresses

      # TODO: Check phone numbers
    end

  end
end
