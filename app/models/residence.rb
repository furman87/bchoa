class Residence < ActiveRecord::Base
  has_many :residence_users
  has_many :users, through: :residence_users
  belongs_to :street #, :foreign_key => "street_id"

  def listing_names
    last_name = ""
    return_name = ""

    residence_users.each do |u|
      return_name += "#{u.user.last_name == last_name ? " &" : u.user.last_name + ','} #{u.user.first_name}"
      last_name = u.user.last_name
    end

    return_name
  end

  def listing_emails
    emails = ""
    users.each do |u|
      emails += emails.length ? "\n#{u.email}" : u.email
    end
    emails
  end

  def listing_phones(display_private)
    phones = ""
    users.each do |u|
      phones += phones.length ? "\n#{u.display_phone(display_private)}" : u.display_phone(display_private)
    end
    phones
  end

  def address
    "#{street_number} #{street.street_name}"
  end
end
