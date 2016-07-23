class AddPrivateToUser < ActiveRecord::Migration

  def change

    add_column :users, :email_is_private, :boolean
    add_column :users, :spouse_email_is_private, :boolean
    add_column :users, :phone_is_private, :boolean
    add_column :users, :spouse_phone_is_private, :boolean
    rename_column :users, :phone_number, :phone
  end
end
