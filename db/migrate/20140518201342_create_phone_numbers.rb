class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers, id: false do |t|
      t.integer :id
      t.string :phone_type
      t.integer :phone_type_id
      t.integer :phone_ref
      t.boolean :listed
      t.string :phone_number
      t.boolean :preferred
      t.boolean :family_phone
      t.boolean :address_phone
      t.string :extension

      t.timestamps
    end

    add_index(:phone_numbers, :id, :unique => true, :name => 'phone_numbers_id_index')
  end
end
