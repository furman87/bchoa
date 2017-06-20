class UserMailer < ApplicationMailer
  default from: %("Butler Creek" <btlrcreek@yahoo.com>)
  default to: %("Butler Creek" <btlrcreek@yahoo.com>)

  def send_mail(mail_message_params, author)
    @mail_message = author.articles.build(mail_message_params)
    mail_users = User.select(:id, :email, :last_name, :first_name)
                     .find(@mail_message.mail_users.map {|u| u.to_i}.select {|u| u > 0})
                     .map {|u| %("#{u.first_name} #{u.last_name}" <#{u.email}>)}

    group_users = MailGroup.select("users.id, users.email, users.last_name, users.first_name")
                           .joins(:users)
                           .where(id: @mail_message.mail_groups.map {|g| g.to_i}.select {|g| g > 0})
                           .map {|u| %("#{u.first_name} #{u.last_name}" <#{u.email}>)}

    unique_users = group_users | mail_users

    # Rails.logger.debug unique_users

    mail(to: %("Butler Creek" <btlrcreek@yahoo.com>), bcc: unique_users, subject: @mail_message.title)
  end

  def send_password(user)
    @user = user
    @admin = BoardMember.web_admin
    mail(to: @user.email, subject: "Butler Creek password")
  end
  
end
