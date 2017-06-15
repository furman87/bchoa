class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :set_return_to, only: [:new, :edit, :destroy]
  before_action :authenticate_user!

  def index
    authorize_action_for(User)
    @users = User.includes(:residences).joins(:residences).order(:last_name, :first_name)
    @can_update_user = current_user.can_update?(User)
  end

  def new
    @user = User.new
    @user.created_at = DateTime.now
    @user.updated_at = @user.created_at
    authorize_action_for(@user)
  end

  def edit
    authorize_action_for(@user)
  end

  def create
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user][:password] = "changeme!"
      # params[:user][:password] = Devise.friendly_token[0,20]
    end

    @user = User.new(user_params)
    authorize_action_for(@user)

    if @user.save
      redirect_to session[:return_to] ? session.delete(:return_to) : root_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize_action_for(@user)
    if @user.update(user_params)
      redirect_to session.delete(:return_to), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize_action_for(@user)
    @user.destroy
    redirect_to session.delete(:return_to), notice: 'User was successfully deleted.'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_return_to
      session[:return_to] ||= request.referer
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :phone_is_private, :created_at, :updated_at, :password)
    end
end
