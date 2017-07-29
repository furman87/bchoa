class MailGroup < ActiveRecord::Base
  include Authority::Abilities
  has_many :mail_group_members
  has_many :users, through: :mail_group_members
end
