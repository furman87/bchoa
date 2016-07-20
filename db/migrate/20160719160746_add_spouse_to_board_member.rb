class AddSpouseToBoardMember < ActiveRecord::Migration
  def change
    add_column :board_members, :spouse, :boolean
    add_column :board_members, :include_last_name, :boolean
    add_column :board_members, :term_end, :date
  end
end
