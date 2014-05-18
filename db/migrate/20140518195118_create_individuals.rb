class CreateIndividuals < ActiveRecord::Migration
  def change
    create_table :individuals, id: false do |t|
      t.integer :id, :options => 'PRIMARY KEY'
      t.integer :family_id
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :goes_by_name
      t.string :title
      t.string :picture_url
      t.string :family_position
      t.string :suffix
      t.string :full_name
      t.string :friendly_name
      t.string :family_picture_url
      t.datetime :date_of_birth
      t.string :member_status

      t.timestamps
    end

    add_index(:individuals, :id, :unique => true, :name => 'id_index')
  end
end
