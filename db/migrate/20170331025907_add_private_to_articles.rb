class AddPrivateToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_private, :boolean
  end
end
