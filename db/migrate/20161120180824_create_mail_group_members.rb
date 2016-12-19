class CreateMailGroupMembers < ActiveRecord::Migration
  def change
    create_table :mail_group_members do |t|
      t.integer :mail_group_id
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :mail_group_members, [:mail_group_id, :user_id], unique: true
  end
end
