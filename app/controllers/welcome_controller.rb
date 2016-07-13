class WelcomeController < ApplicationController

  def index
    @articles = Article.tagged_with("news").where("end_date > ?", Date.today).order("id desc").limit(4)
  end

end
