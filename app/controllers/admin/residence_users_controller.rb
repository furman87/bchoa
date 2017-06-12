class Admin::ResidenceUsersController < ApplicationController
  before_action :set_residence_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @residence = Residence.find(params[:residence_id])
    @residence_user = @residence.residence_users.build
    authorize_action_for(@residence_user)
  end

  def edit
    authorize_action_for(@residence_user)
  end

  def create
    @residence_user = ResidenceUser.new(residence_user_params)
    authorize_action_for(@residence_user)

    if @residence_user.save
      redirect_to admin_residence_path(@residence_user.residence_id), notice: 'User was successfully added to residence.'
    else
      render :new
    end
  end

  def update
    authorize_action_for(@residence_user)
    if @residence_user.update(residence_user_params)
      redirect_to admin_residence_path(@residence_user.residence_id), notice: 'User was successfully updated in residence.'
    else
      render :edit
    end
  end

  def destroy
    authorize_action_for(@residence_user)
    residence = @residence_user.residence
    @residence_user.destroy
    redirect_to admin_residence_path(residence.id), notice: "User was successfully removed from residence."
  end

  private
    def set_residence_user
      @residence_user = ResidenceUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def residence_user_params
      params.require(:residence_user).permit(:user_id, :residence_id, :is_owner, :is_resident, :display_order)
    end
end
