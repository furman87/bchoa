class CreateAccRequests < ActiveRecord::Migration
  def change
    create_table :acc_requests do |t|
      t.integer :user_id
      t.integer :residence_id
      t.integer :project_types, array: true
      t.text :description
      t.string :material
      t.integer :areas_affected, array: true
      t.boolean :third_party
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
