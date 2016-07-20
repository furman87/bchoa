class BlockCaptainsController < ApplicationController

  def index
    @block_captains = BlockCaptain.includes(:user).order(:display_order)
  end
end
