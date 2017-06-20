class BoardMember < ActiveRecord::Base
  belongs_to :user

  def self.web_admin
    BoardMember.where(description: "Web Administrator").first
  end

end
