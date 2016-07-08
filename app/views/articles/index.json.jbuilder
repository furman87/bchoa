json.array!(@articles) do |article|
  json.extract! article, :id, :user_id, :title, :body, :start_date, :end_date
  json.url article_url(article, format: :json)
end
