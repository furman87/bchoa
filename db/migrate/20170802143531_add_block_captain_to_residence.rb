class AddBlockCaptainToResidence < ActiveRecord::Migration
  def change
    add_column :residences, :block_captain_id, :integer
    add_index :residences, :block_captain_id
  end
end
