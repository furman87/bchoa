class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title, limit: 50
      t.text :body
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
