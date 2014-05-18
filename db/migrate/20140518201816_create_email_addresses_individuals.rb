class CreateEmailAddressesIndividuals < ActiveRecord::Migration
  def change
    create_table :email_addresses_individuals do |t|
      t.references :email_address, index: true
      t.references :individual, index: true

      t.timestamps
    end
  end
end
