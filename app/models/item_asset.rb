class ItemAsset < ActiveRecord::Base
  belongs_to :item, :polymorphic => true

  # has_attached_file :document
  has_attached_file :asset, :styles => lambda { |a| { :thumbnail => "200>", :medium => "500>", :large => "1000>" } if a.instance.is_image? }

  validates_attachment_content_type :asset,
      :content_type => ['application/pdf',
                        'application/vnd.ms-excel',
                        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                        'image/png',
                        'image/gif',
                        'image/jpeg'],
      :message => "Only PDF, XSL, XSLX, PNG, GIF, and JPG files are allowed"

  def is_image?
    return false unless /image\//.match(asset.content_type)
  end
end
