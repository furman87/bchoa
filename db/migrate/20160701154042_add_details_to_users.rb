class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string, :limit => 50
    add_column :users, :first_name, :string, :limit => 50
    add_column :users, :spouse_name, :string, :limit => 75
    add_column :users, :street_number, :integer
    add_column :users, :street_id, :integer
    add_column :users, :lot, :integer
    add_column :users, :block, :integer
    add_column :users, :phone_number, :string, :limit => 15
    add_column :users, :spouse_phone, :string, :limit => 15
    add_column :users, :spouse_email, :string, :limit => 50
    add_column :users, :purchase_year, :integer
    add_column :users, :leased, :boolean
    add_column :users, :leasing_owner, :string, :limit => 50
    add_column :users, :leasing_address, :string, :limit => 75
    add_column :users, :leasing_phone, :string, :limit => 15
    add_column :users, :leasing_email, :string, :limit => 50
  end
end
