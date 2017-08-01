class Admin::BlockCaptainsController < ApplicationController
  before_action :set_block_captain, only: [:edit, :update, :destroy]
  before_action :set_users, only: [:new, :edit]
  before_action :authenticate_user!

  def index
    authorize_action_for(BlockCaptain)
    @block_captains = BlockCaptain.includes(:user).order(:display_order)
  end

  def new
    @block_captain = BlockCaptain.new
    authorize_action_for(@block_captain)
  end

  def edit
    authorize_action_for(@block_captain)
  end

  def create
    @block_captain = BlockCaptain.new(block_captain_params)
    authorize_action_for(@block_captain)

    if @block_captain.save
      redirect_to admin_block_captains_path, notice: 'Block captain was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize_action_for(@block_captain)
    if @block_captain.update(block_captain_params)
      redirect_to admin_block_captains_path, notice: 'Mail group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize_action_for(@block_captain)
    @block_captain.destroy
    redirect_to admin_block_captains_path, notice: 'Block captain was successfully deleted.'
  end

  private

  def set_block_captain
    @block_captain = BlockCaptain.find(params[:id])
  end

  def set_users
    @users = User.order(:last_name, :first_name)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def block_captain_params
    params.require(:block_captain).permit(:description, :user_id, :display_order)
  end
end
