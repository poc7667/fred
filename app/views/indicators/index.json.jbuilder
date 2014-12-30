json.array!(@indicators) do |indicator|
  json.extract! indicator, :id, :id, :name, :category
  json.url indicator_url(indicator, format: :json)
end
