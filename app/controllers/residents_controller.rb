class ResidentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @residents = User.includes(:street).order(:last_name, :first_name)
  end
end
