class CreateBoardMembers < ActiveRecord::Migration
  def change
    create_table :board_members do |t|
      t.string :description, limit: 25
      t.integer :user_id
      t.integer :display_order

      t.timestamps null: false
    end
  end
end
