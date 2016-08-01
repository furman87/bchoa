class CreateArticleAssets < ActiveRecord::Migration
  def change
    create_table :article_assets do |t|
      t.integer :article_id
      t.string :description, limit: 75

      t.timestamps null: false
    end
    # Paperclip attachment called asset added to article_assets
    add_attachment :article_assets, :asset
  end
end
