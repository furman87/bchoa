class MailMessagesController < ApplicationController
  before_action :set_mail_message, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @mail_message = current_user.articles.build(tag_list: "mail")
    @mail_groups = MailGroup.order(:name)
    @mail_users = User.order("last_name, first_name")

    authorize_action_for(@mail_message)
    session[:return_to] ||= request.referer
  end

  def create
    @mail_message = current_user.articles.build(mail_message_params)
    authorize_action_for(@mail_message)

    UserMailer.send_mail(mail_message_params, current_user).deliver_later
    redirect_to session.delete(:return_to), notice: 'Mail was successfully created.'
  end

  private

  def set_mail_message
    @mail_message = MailMessage.find(params[:id])
  end

  def mail_message_params
    params.require(:article).permit(:id, :user_id, :title, :body, :tag_list, :mail_users => [], :mail_groups => [], article_assets_attributes: [:id, :asset, :description, :display_order, :_destroy])
  end
end
