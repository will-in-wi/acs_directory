class AddForeignKeys < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :addresses_individuals, :addresses
    add_foreign_key :addresses_individuals, :individuals
    add_foreign_key :email_addresses_individuals, :individuals
    add_foreign_key :email_addresses_individuals, :email_addresses
    add_foreign_key :individuals_phone_numbers, :individuals
    add_foreign_key :individuals_phone_numbers, :phone_numbers
  end
end
