json.array!(@ratings) do |rating|
  json.extract! rating, :id, :user_id, :post_id, :rate
  json.url rating_url(rating, format: :json)
end
