class AddDisplayOrderToArticleAssets < ActiveRecord::Migration
  def change
    add_column :article_assets, :display_order, :integer
  end
end
