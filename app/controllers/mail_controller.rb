class MailController < ApplicationController
  def new
    @mail_message = current_user.mail_messages.build
    authorize_action_for(@mail_message)
    session[:return_to] ||= request.referer
  end

  def create
    @mail_message = MailMessage.create(mail_message_params)
    authorize_action_for(@mail_message)
    UserMailer.send_mail(@mail_message).deliver_later

    redirect_to session.delete(:return_to), notice: 'Email was successfully sent.'
  end

  private

  def mail_message_params
    params.require(:mail_message).permit(:user_id, :title, :body)
  end
end
