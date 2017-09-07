class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :path
      t.string :include_tags
      t.string :title
      t.text :body

      t.timestamps null: false
    end
    add_index :pages, :path
  end
end
