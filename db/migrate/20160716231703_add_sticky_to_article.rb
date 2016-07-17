class AddStickyToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :sticky, :boolean, default: false
  end
end
