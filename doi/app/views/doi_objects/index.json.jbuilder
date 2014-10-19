json.array!(@doi_objects) do |doi_object|
  json.extract! doi_object, :id, :name, :description
  json.url doi_object_url(doi_object, format: :json)
end
