class Residence < ActiveRecord::Base
  has_many :residence_users
  has_many :users, through: :residence_users
  belongs_to :street #, :foreign_key => "street_id"

  def self.with_street
    includes(:street).joins(:street)
  end

  def self.with_user
    includes(:users).joins(:users)
  end

  def self.by_last_name
    order("users.last_name")
  end
  
  def self.by_first_name
    order("users.first_name")
  end
  
  def listing_names
    last_name = ""
    return_name = ""
    residents = users

    residents.each do |u|
      return_name += "#{u.last_name == last_name ? " &" : u.last_name + ','} #{u.first_name}"
      last_name = u.last_name
    end

    return_name
  end

  def listing_emails
    emails = ""
    users.each do |u|
      if !u.email.include? ENV['ignore_listing_domain']
        emails += emails.length ? "\n#{u.email}" : u.email
      end
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
