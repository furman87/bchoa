class MailGroupMember < ActiveRecord::Base
  belongs_to :mail_group
  belongs_to :user
end
