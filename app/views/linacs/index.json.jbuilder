json.array!(@linacs) do |linac|
  json.extract! linac, :id, :name, :user_group_id
  json.url linac_url(linac, format: :json)
end
