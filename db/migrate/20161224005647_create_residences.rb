class CreateResidences < ActiveRecord::Migration
  def change
    create_table :residences do |t|
      t.integer :street_number
      t.integer :street_id
      t.integer :lot
      t.integer :block

      t.timestamps null: false
    end

    create_table :residence_users do |t|
      t.integer :residence_id, index: true
      t.integer :user_id, index: true
      t.boolean :is_resident, default: true
      t.boolean :is_owner, default: true
      t.integer :year
    end
  end
end
