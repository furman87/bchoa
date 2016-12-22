class CreateMailGroups < ActiveRecord::Migration
  def change
    create_table :mail_groups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
