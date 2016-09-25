class UserMailer < ApplicationMailer
  default from: %("Butler Creek" <btlrcreek@yahoo.com>)

  def send_mail(mail_message)
    @mail_message = mail_message
    mail(to: %("Butler Creek" <btlrcreek@yahoo.com>),
         bcc: User.where("(last_name = 'Watson' and first_name = 'Ken') or last_name = 'Vogel'").pluck(:email),
         subject: @mail_message.title)
  end
end
