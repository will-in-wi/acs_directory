FactoryGirl.define do
  factory :individual do
    factory :person1_individual do
      # Should match person1.json
      id 2
      family_id 1001
      last_name 'Doe'
      first_name 'John'
      middle_name nil
      goes_by_name nil
      suffix nil
      title nil
      full_name 'Doe, John '
      friendly_name 'John Doe'
      picture_url ''
      family_picture_url ''
      date_of_birth '1956-02-15'
      member_status 'Transfer fr Lutheran'
      family_position 'Head'
    end

    factory :person1_individual_with_children do
      # Should match person1.json
      id 2
      family_id 1001
      last_name 'Doe'
      first_name 'John'
      middle_name nil
      goes_by_name nil
      suffix nil
      title nil
      full_name 'Doe, John '
      friendly_name 'John Doe'
      picture_url ''
      family_picture_url ''
      date_of_birth '1956-02-15'
      member_status 'Transfer fr Lutheran'
      family_position 'Head'

      after(:build) do |individual, evaluator|
        individual.email_addresses << FactoryGirl.build(:person1_email)
        individual.addresses << FactoryGirl.build(:person1_address)
        individual.phone_numbers << FactoryGirl.build(:person1_phone_number)
      end
    end

    # Family

    factory :individual_head do
      id 1
      family_id 1001
      last_name 'Doe'
      first_name 'John'
      family_position 'Head'
      family_picture_url 'http://example.com/picture.jpg'
    end

    factory :individual_spouse do
      id 2
      family_id 1001
      last_name 'Doe'
      first_name 'Jane'
      family_position 'Spouse'
      family_picture_url 'http://example.com/picture.jpg'
    end

    factory :individual_child do
      sequence(:id, 3)
      family_id 1001
      last_name 'Doe'
      sequence(:first_name) { |n| "child#{n}" }
      family_position 'Child'
      family_picture_url 'http://example.com/picture.jpg'
    end
  end
end
