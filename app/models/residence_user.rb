class ResidenceUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :residence

  def self.with_user
    includes(:user).joins(:user)
  end

  def self.by_display_order
    order("residence_users.display_order")
  end
end
