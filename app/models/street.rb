class Street < ActiveRecord::Base
  has_many :users

  def name
    street_name
  end
end
