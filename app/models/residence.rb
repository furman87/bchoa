class Residence < ActiveRecord::Base
  has_many :residence_users
  has_many :users, through: :residence_users
  belongs_to :street #, :foreign_key => "street_id"
end
