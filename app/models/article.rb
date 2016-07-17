class Article < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdminAuthorizer'
  acts_as_taggable
  belongs_to :user

  scope :current, -> { where("start_date <= ? and end_date > ?", Date.today, Date.today) }
  scope :by_publish_date, -> { order("sticky, start_date desc") }
end
