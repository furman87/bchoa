class BoardMembersController < ApplicationController
  
  def index
    @board_members = BoardMember.includes(:user).order(:display_order)
  end
end
