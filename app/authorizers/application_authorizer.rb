# Other authorizers should subclass this one
class ApplicationAuthorizer < Authority::Authorizer

    # Any class method from Authority::Authorizer that isn't overridden
    # will call its authorizer's default method.
    #
    # @param [Symbol] adjective; example: `:creatable`
    # @param [Object] user - whatever represents the current user in your app
    # @return [Boolean]
    # def self.default(adjective, user)
    #   # 'Whitelist' strategy for security: anything not explicitly allowed is
    #   # considered forbidden.
    #   false
    # end

    # Class methods: can this user at least sometimes create a Schedule?
    def self.creatable_by?(user)
      user.has_any_role? :admin, :board
    end

    def self.updatable_by?(user)
      user.has_any_role? :admin, :board
    end

    def self.readable_by?(user)
      user.has_any_role? :admin, :board
    end

    # Instance methods
    def creatable_by?(user)
      user.has_any_role? :admin, :board
    end

    def updatable_by?(user)
      user.has_any_role? :admin, :board
    end

    def deletable_by?(user)
      user.has_any_role? :admin
    end

    def readable_by?(user)
      user.has_any_role? :admin, :board
    end
end
