class AddDisplayOrderToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :display_order, :integer
  end
end
