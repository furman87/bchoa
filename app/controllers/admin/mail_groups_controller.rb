class Admin::MailGroupsController < ApplicationController
  before_action :set_mail_group, only: [:edit, :update, :destroy, :add_members, :remove_members]
  # before_action :authenticate_user!
  
  def index
    @mail_groups = MailGroup.order(:name)
  end
  
  def new
  end

  def edit
    @members = User
      .where("users.email not like '%#{ENV['ignore_listing_domain']}%'")
      .where("users.id in (?)", @mail_group.users.map {|u| u.id})
      .with_residences.order(:last_name).order(:first_name)
      .merge(ResidenceUser.with_residence.only_residents.by_display_order)
      .merge(Residence.with_street)

    @non_members = User
      .where("users.email not like '%#{ENV['ignore_listing_domain']}%'")
      .where("users.id not in (?)", MailGroup.joins(:users).includes(:users).pluck("users.id"))
      .with_residences.order(:last_name).order(:first_name)
      .merge(ResidenceUser.with_residence.only_residents.by_display_order)
      .merge(Residence.with_street)
  end

  def add_members
    @mail_group.users << User.find(params[:member_ids])
    redirect_to edit_admin_mail_group_path(@mail_group)
  end

  def remove_members
    @mail_group.users.delete(User.find(params[:member_ids]))
    redirect_to edit_admin_mail_group_path(@mail_group)
  end

  private
  
  def set_mail_group
    @mail_group = MailGroup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def mail_group_params
    params.require(:mail_group).permit(:name)
  end
end
