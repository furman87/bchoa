class Street < ActiveRecord::Base
  has_many :residences

  def name
    street_name
  end
end
