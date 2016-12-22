# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  default from: %("Butler Creek" <btlrcreek@yahoo.com>)

  def send_mail(mail_message)
    @mail_message = mail_message
    mail(to: %("Butler Creek" <btlrcreek@yahoo.com>),
         bcc: User.where("(last_name = 'Watson' and first_name = 'Ken')").pluck(:email),
         subject: @mail_message.title)
  end
end
