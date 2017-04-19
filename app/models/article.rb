class Article < ActiveRecord::Base
  include Authority::Abilities
  acts_as_taggable

  attr_accessor :mail_groups, :mail_users, :is_mail

  belongs_to :user
  has_many :article_assets, -> { order(:display_order) }
  accepts_nested_attributes_for :article_assets, reject_if: :all_blank, allow_destroy: true

  def self.current
    where("? between start_date and end_date", Date.today)
  end

  def self.by_publish_date
    order("sticky desc, start_date desc")
  end

  def self.by_display_order
    order("sticky desc, display_order")
  end

  def self.only_private(show_private)
    where("coalesce(is_private, false) = false or ?", show_private)
  end
end
