class CreateItemAssets < ActiveRecord::Migration
  def change
    create_table :item_assets do |t|
      t.string :item_type
      t.integer :item_id
      t.string :description, limit: 75
    end
    add_index :item_assets, [:item_type, :item_id]

    # Paperclip attachment called asset added to item_assets
    add_attachment :item_assets, :asset
  end
end
