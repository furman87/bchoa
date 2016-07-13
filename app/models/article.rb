class Article < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdminAuthorizer'
  acts_as_taggable
  belongs_to :user
end
