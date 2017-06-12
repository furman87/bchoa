class ResidentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @residences = Residence.with_street.with_user.merge(ResidenceUser.with_user.only_residents.by_display_order).by_last_name.by_first_name
    @can_update_user = current_user.can_update?(User)
    @can_display_private = current_user.can_update?(User)
  end
end
