class BoardMember < ActiveRecord::Base
  include Authority::Abilities
  belongs_to :user

  def self.web_admin
    BoardMember.where(description: "Web Administrator").first
  end

end
