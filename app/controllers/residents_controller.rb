class ResidentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @residences = Residence.with_street.by_user.merge(ResidenceUser.includes(:user).order("residence_users.display_order")).order("users.first_name")
    @can_update_user = current_user.can_update?(User)
    @can_display_private = current_user.can_update?(User)
  end
end
