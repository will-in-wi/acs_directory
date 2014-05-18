class CreateEmailAddresses < ActiveRecord::Migration
  def change
    create_table :email_addresses, id: false do |t|
      t.integer :id
      t.boolean :listed
      t.boolean :preferred
      t.string :email_type
      t.string :email_address

      t.timestamps
    end

    add_index(:email_addresses, :id, :unique => true, :name => 'email_addresses_id_index')
  end
end
