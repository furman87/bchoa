class AddEmailToBoardMembers < ActiveRecord::Migration
  def change
    add_column :board_members, :email, :string
  end
end
