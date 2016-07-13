class AdminAuthorizer < Authority::Authorizer

  # Class method: can this user at least sometimes create a Schedule?
  def self.creatable_by?(user)
    user.has_any_role? :admin, :board
  end

  def creatable_by?(user)
    user.has_any_role? :admin, :board
  end

  def updatable_by?(user)
    user.has_any_role? :admin, :board
  end

  def deletable_by?(user)
    user.has_any_role? :admin
  end

end
