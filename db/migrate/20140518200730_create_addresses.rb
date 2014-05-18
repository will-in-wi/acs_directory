class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses, id: false do |t|
      t.integer :id, options: 'PRIMARY KEY'
      t.string :address_type
      t.boolean :mailing_address
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.decimal :latitude
      t.decimal :longitude
      t.boolean :active
      t.boolean :family_address
      t.string :company
      t.boolean :statement_address
      t.integer :address_type_id

      t.timestamps
    end

    add_index(:addresses, :id, :unique => true, :name => 'addresses_id_index')
  end
end
