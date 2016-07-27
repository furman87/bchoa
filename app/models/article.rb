class Article < ActiveRecord::Base
  include Authority::Abilities
  acts_as_taggable

  belongs_to :user
  has_many :item_assets, :as => :item
  accepts_nested_attributes_for :item_documents

  scope :current, -> { where("start_date <= ? and end_date > ?", Date.today, Date.today) }
  scope :by_publish_date, -> { order("sticky desc, start_date desc") }
end
