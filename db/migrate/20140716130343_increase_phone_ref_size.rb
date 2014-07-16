class IncreasePhoneRefSize < ActiveRecord::Migration
  def change
    change_column :phone_numbers, :phone_ref, :integer, limit: 8
  end
end
