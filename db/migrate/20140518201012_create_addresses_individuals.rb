class CreateAddressesIndividuals < ActiveRecord::Migration
  def change
    create_table :addresses_individuals do |t|
      t.references :address, index: true
      t.references :individual, index: true

      t.timestamps
    end
  end
end
