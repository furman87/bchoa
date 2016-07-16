require 'csv'

class User < ActiveRecord::Base
  include Authority::UserAbilities
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      User.create! row.to_hash do |u|
        u.leasing_owner = ('a'..'z').to_a.shuffle[0,8].join
        u.password = u.leasing_owner
      end
    end
  end

end
