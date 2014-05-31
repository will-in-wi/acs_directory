FactoryGirl.define do
  factory :email_address do
    factory :person1_email do
      # Should match person1.json
      id 2
      email_type 'Personal'
      preferred true
      email_address 'jdoe@example.com'
      listed true
    end
  end
end
