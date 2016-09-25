class MailAuthorizer < ApplicationAuthorizer
    # Class methods: can this user at least sometimes create a Schedule?
    def self.creatable_by?(user)
      user.has_any_role? :secretary
    end

    # Instance methods
    def creatable_by?(user)
      user.has_any_role? :secretary
    end
end
