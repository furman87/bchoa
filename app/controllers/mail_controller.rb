class MailController < ApplicationController
  def new
    @mail = Article.build(user_id: current_user.id)
  end

  def create
    @mail = Article.build(article_params)
    UserMailer.send_mail(@mail).deliver_later
  end

  private

  def article_params
    params.require(:article).permit(:user_id, :title, :body)
  end
end
