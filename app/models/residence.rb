class Residence < ActiveRecord::Base
  include Authority::Abilities
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

  def user_names
    residents = residence_users.with_user.only_residents.by_display_order
    test_last_name = ""
    return_name = ""

    residents.each_with_index do |r, index|
      if index == 0
        return_name += r.user.last_first
      else
        return_name += " & " + (r.user.last_name == test_last_name ? r.user.first_name : r.user.last_first)
      end
      test_last_name = r.user.last_name
    end

    return_name
  end

  def user_emails
    emails = ""
    users.each do |u|
      if !u.email.include? ENV['ignore_listing_domain']
        emails += emails.length ? "\n#{u.email}" : u.email
      end
    end
    emails
  end

  def user_phones(display_private)
    users.map {|u| u.display_phone(display_private)}.uniq.join("\n")
  end

  def address
    "#{street_number} #{street.street_name}"
  end
end
