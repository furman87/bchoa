class RemoveSpouseFromBlockCaptains < ActiveRecord::Migration
  def change
    remove_column :block_captains, :spouse, :boolean
  end
end
