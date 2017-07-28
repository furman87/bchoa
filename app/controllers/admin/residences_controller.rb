class Admin::ResidencesController < ApplicationController
  include Authority::Controller
  before_action :set_residence, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def show
    authorize_action_for(@residence)
    @owners = @residence.residence_users.with_user.only_owners.order(:display_order)
    @residents = @residence.residence_users.with_user.only_residents.order(:display_order)
    @users = @residence.residence_users.with_user.order(:display_order)
  end

  def new
    @residence = Residence.new
    authorize_action_for(@residence)
    session[:return_to] ||= request.referer
  end

  def edit
    authorize_action_for(@residence)
    session[:return_to] ||= request.referer
  end

  def create
    @residence = Residence.new(residence_params)

    if @residence.save
      redirect_to session[:return_to] ? session.delete(:return_to) : root_path, notice: 'Residence was successfully created.'
    else
      render :new
    end
  end

  def update
    if @residence.update(residence_params)
      redirect_to session.delete(:return_to), notice: 'Residence was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_residence
      @residence = Residence.with_street.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def residence_params
      params.require(:residence).permit(:street_number, :lot, :block, :purchase_year)
    end
end
