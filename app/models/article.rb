class Article < ActiveRecord::Base
  include Authority::Abilities
  acts_as_taggable

  belongs_to :user
  has_many :article_assets
  accepts_nested_attributes_for :article_assets, reject_if: :all_blank, allow_destroy: true

  # scope :current, -> { where("start_date <= ? and end_date > ?", Date.today, Date.today) }
  scope :current, -> { where("? between start_date and end_date", Date.today) }
  scope :by_publish_date, -> { order("sticky desc, start_date desc") }
  scope :by_display_order, -> { order("sticky desc, display_order") }
end
