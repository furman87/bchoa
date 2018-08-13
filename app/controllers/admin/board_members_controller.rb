class Admin::BoardMembersController < ApplicationController
  before_action :set_board_member, only: [:edit, :update, :destroy]
  before_action :set_users, only: [:new, :edit]
  before_action :authenticate_user!

  def index
    authorize_action_for(BoardMember)
    @board_members = BoardMember.includes(:user).order(:display_order)
  end

  def new
    @board_member = BoardMember.new
    authorize_action_for(@board_member)
  end

  def edit
    authorize_action_for(@board_member)
  end

  def create
    @board_member = BoardMember.new(board_member_params)
    authorize_action_for(@board_member)

    if @board_member.save
      redirect_to admin_board_members_path, notice: 'Board member was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize_action_for(@board_member)
    if @board_member.update(board_member_params)
      redirect_to admin_board_members_path, notice: 'Board member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize_action_for(@board_member)
    @board_member.destroy
    redirect_to admin_board_members_path, notice: 'Board member was successfully deleted.'
  end

  private

  def set_board_member
    @board_member = BoardMember.find(params[:id])
  end

  def set_users
    @users = User.order(:last_name, :first_name)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def board_member_params
    params.require(:board_member).permit(:description, :user_id, :email, :display_order)
  end
end
