class ResidentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @residences = Residence.with_street.by_user.by_user_display_order.all
    @can_update_user = current_user.can_update?(User)
    @can_display_private = current_user.can_update?(User)
  end
end
