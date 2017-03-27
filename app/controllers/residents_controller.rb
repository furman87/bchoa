class ResidentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @residences = Residence.includes(:street).includes(:users).includes(:residence_users).order("users.last_name, residence_users.display_order").all
    @can_update_user = current_user.can_update?(User)
    @can_display_private = current_user.can_update?(User)
  end
end
