class RemoveDetailsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :spouse_name, :string
    remove_column :users, :street_number, :integer
    remove_column :users, :street_id, :integer
    remove_column :users, :lot, :integer
    remove_column :users, :block, :integer
    remove_column :users, :spouse_phone, :string
    remove_column :users, :spouse_email, :string
    remove_column :users, :purchase_year, :integer
    remove_column :users, :leased, :boolean
    remove_column :users, :leasing_owner, :string
    remove_column :users, :leasing_address, :string
    remove_column :users, :leasing_phone, :string
    remove_column :users, :leasing_email, :string
  end
end
