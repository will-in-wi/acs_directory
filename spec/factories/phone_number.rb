FactoryGirl.define do
  factory :phone_number do
    factory :person1_phone_number do
      # Should match person1.json
      id 545
      preferred false
      phone_type_id 6
      phone_type "Business"
      family_phone false
      phone_number "123-456-7890"
      extension nil
      listed true
      address_phone false
      phone_ref 1234567890
    end
  end
end
