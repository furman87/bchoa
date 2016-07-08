class WelcomeController < ApplicationController

  def index
    @articles = Article.tagged_with("news").where("end_date > ?", Date.today).order("created_at desc")
  end
end
