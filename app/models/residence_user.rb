class ResidenceUser < ActiveRecord::Base
  include Authority::Abilities
  belongs_to :user
  belongs_to :residence

  def self.with_user
    includes(:user).joins(:user)
  end

  def self.by_display_order
    order("residence_users.display_order")
  end

  def self.only_owners
    where(is_owner: true)
  end

  def self.only_residents
    where(is_resident: true)
  end

end
