class ResidentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @residences = Residence.includes(:street).includes(:users).order("users.last_name, users.first_name").all
    @can_update_user = current_user.can_update?(User)
    @can_display_private = current_user.can_update?(User)
  end
end
