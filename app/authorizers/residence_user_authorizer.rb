class ResidenceUserAuthorizer < ApplicationAuthorizer
  def self.creatable_by?(user)
    user.has_any_role? :admin, :secretary
  end

  def self.updatable_by?(user)
    user.has_any_role? :admin, :secretary
  end

  def self.readable_by?(user)
    user.has_any_role? :admin, :secretary
  end

  # Instance methods
  def creatable_by?(user)
    user.has_any_role? :admin, :secretary
  end

  def updatable_by?(user)
    user.has_any_role? :admin, :secretary
  end

  def deletable_by?(user)
    user.has_any_role? :admin, :secretary
  end

  def readable_by?(user)
    user.has_any_role? :admin, :secretary
  end
end