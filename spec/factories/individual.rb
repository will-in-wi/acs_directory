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
  end
end
