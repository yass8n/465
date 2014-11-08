json.array!(@images) do |image|
  json.extract! image, :id, :filename, :public, :user_id, :user_id
  json.url image_url(image, format: :json)
end
