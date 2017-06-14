class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.order(:last_name, :first_name)
    @can_update_user = current_user.can_update?(User)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
  end

  def update
    if @user.update(user_params)
      redirect_to session.delete(:return_to), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :phone_is_private)
    end
end
