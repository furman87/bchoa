class Article < ActiveRecord::Base
  include Authority::Abilities
  acts_as_taggable
  belongs_to :user

  scope :current, -> { where("start_date <= ? and end_date > ?", Date.today, Date.today) }
  scope :by_publish_date, -> { order("sticky desc, start_date desc") }
end
