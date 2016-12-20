class Article < ActiveRecord::Base
  include Authority::Abilities
  acts_as_taggable

  attr_accessor :mail_groups, :mail_users, :is_mail

  belongs_to :user
  has_many :article_assets, -> { order(:display_order) }
  accepts_nested_attributes_for :article_assets, reject_if: :all_blank, allow_destroy: true

  scope :current, -> { where("? between start_date and end_date", Date.today) }
  scope :by_publish_date, -> { order("sticky desc, start_date desc") }
  scope :by_display_order, -> { order("sticky desc, display_order") }
end
