class Residence < ActiveRecord::Base
  has_many :residence_users
  has_many :users, through: :residence_users
  belongs_to :street #, :foreign_key => "street_id"

  def self.with_street
    includes(:street).joins(:street)
  end

  def self.by_user
    # includes(:users).joins(:users).order("users.last_name, users.first_name")
    includes(:users).joins(:users).order("users.last_name")
  end
  
  def self.with_residence_users
    includes(:residence_users).joins(:residence_users).order("residence_users.display_order")
  end

  def listing_names
    last_name = ""
    return_name = ""
    # residents = residence_users.sort {|x, y| x.display_order <=> y.display_order}
    residents = users

    residents.each do |u|
      # return_name += "#{u.user.last_name == last_name ? " &" : u.user.last_name + ','} #{u.user.first_name}"
      # last_name = u.user.last_name
      return_name += "#{u.last_name == last_name ? " &" : u.last_name + ','} #{u.first_name}"
      last_name = u.last_name
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
