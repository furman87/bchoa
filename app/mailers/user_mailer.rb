class UserMailer < ApplicationMailer
  default from: "furman87@gmail.com"
  default to: "ken.watson@pobox.com"

  def send_mail(mail_message)
    @mail_message = mail_message
    mail(subject: @mail_message.title)
  end
end
