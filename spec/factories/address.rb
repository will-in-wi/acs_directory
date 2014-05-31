FactoryGirl.define do
  factory :address do
    factory :person1_address do
      # Should match person1.json
      id 3
      address_type_id 4
      address_type 'Home'
      family_address true
      active true
      mailing_address true
      statement_address true
      country 'USA'
      company nil
      address '123 Sesame Street'
      address2 nil
      city 'Metroville'
      state 'MN'
      zip_code '12345-1234'
    end
  end
end
