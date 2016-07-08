class CreateBlockCaptains < ActiveRecord::Migration
  def change
    create_table :block_captains do |t|
      t.string :description, limit: 100
      t.integer :user_id
      t.boolean :spouse
      t.integer :display_order

      t.timestamps null: false
    end
  end
end
