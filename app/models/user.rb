require 'csv'

class User < ActiveRecord::Base
  include Authority::UserAbilities
  include Authority::Abilities
  rolify
  authorizer = ResidenceAuthorizer
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles
  has_many :mail_group_members
  has_many :mail_groups, through: :mail_group_members

  has_many :residence_users
  has_many :residences, through: :residence_users

  validates_format_of :phone, with: /\d{3}-\d{3}-\d{4}/, allow_blank: true, message: "format must be 999-999-9999"

  def self.with_residences
    joins(:residences).includes(:residences)
  end

  def first_last
    "#{first_name} #{last_name}"
  end

  def last_first
    "#{last_name}, #{first_name}"
  end

  def last_name_first
    name = last_first
    name += " & #{spouse_name}" if spouse_name?
    name
  end

  def email_recipient
    %("#{first_last}" <#{email}>)
  end

  def address
    residence.street_number.to_s + " " + residence.street.name
  end

  def display_phone(display_private)
    (display_private || !phone_is_private) ? (phone || "") : ""
  end

  def self.generate_password
    [*'0'..'9', *'a'..'z', *'A'..'Z'].sample(12).join
  end

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      User.create! row.to_hash do |u|
        u.leasing_owner = generate_password
        u.password = u.leasing_owner
      end
    end
  end

end
