class CreateIndividualsPhoneNumbers < ActiveRecord::Migration
  def change
    create_table :individuals_phone_numbers do |t|
      t.references :individual, index: true
      t.references :phone_number, index: true

      t.timestamps
    end
  end
end
