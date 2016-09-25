require 'csv'

class User < ActiveRecord::Base
  include Authority::UserAbilities
  include Authority::Abilities
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles
  has_many :mail_messages
  
  belongs_to :street, :foreign_key => "street_id"

  validates_format_of :phone, with: /\d{3}-\d{3}-\d{4}/, allow_blank: true, message: "format must be 999-999-9999"
  validates_format_of :spouse_phone, with: /\d{3}-\d{3}-\d{4}/, allow_blank: true, message: "format must be 999-999-9999"

  def first_last
    "#{first_name} #{last_name}"
  end

  def last_name_first
    name = "#{last_name}, #{first_name}"
    name += " & #{spouse_name}" if spouse_name?
    name
  end

  def address
    street_number.to_s + " " +street.name
  end

  def display_phone(display_private)
    display_private || !phone_is_private ? phone : ""
  end

  def display_spouse_phone(display_private)
    display_private || !spouse_phone_is_private ? spouse_phone : ""
  end

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      User.create! row.to_hash do |u|
        u.leasing_owner = ('a'..'z').to_a.shuffle[0,8].join
        u.password = u.leasing_owner
      end
    end
  end

end
