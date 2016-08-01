class ArticleAsset < ActiveRecord::Base
  belongs_to :article

  # has_attached_file :asset
  has_attached_file :asset, styles: { thumb: "200x200>", :medium => "500x500>", :large => "800x800>" }
  validates_attachment_presence :asset
  validates_attachment_content_type :asset, content_type: ['image/jpeg',
                                                           'image/png',
                                                           'image/gif',
                                                           'application/pdf']
  before_post_process :only_for_image

  def only_for_image
    is_image?
  end

  def is_image?
    %w(image/jpeg image/png image/gif).include?(asset_content_type)
  end
end
