class ResidentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @residents = User.includes(:street).order(:last_name, :first_name)
    @can_update_user = current_user.can_update?(User)
    @can_display_private = current_user.can_update?(User)
  end
end
