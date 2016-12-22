class MailGroup < ActiveRecord::Base
  has_many :mail_group_members
  has_many :users, through: :mail_group_members
end
