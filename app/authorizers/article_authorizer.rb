class ArticleAuthorizer < ApplicationAuthorizer
    # Class methods: can this user at least sometimes create a Schedule?

    # Instance methods
    def creatable_by?(user)
      if @mail_message
        if @mail_message.is_mail
          user.has_role? :secretary
        else
          user.has_any_role? :admin, :editor
        end
      else
        user.has_role? :secretary
      end
    end
end
