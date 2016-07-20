require 'csv'

class User < ActiveRecord::Base
  include Authority::UserAbilities
  include Authority::Abilities
  self.authorizer_name = 'AdminAuthorizer'
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles
  belongs_to :street, :foreign_key => "street_id"

  validates_format_of :phone_number, with: /\d{3}-\d{3}-\d{4}/, message: "Phone format must be 999-999-9999"

  def last_name_first
    name = "#{last_name}, #{first_name}"
    name += " & #{spouse_name}" if spouse_name?
    name
  end

  def address
    "#{street_number} #{street.name}"
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
