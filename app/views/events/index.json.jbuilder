json.array!(@events) do |event|
  json.extract! event, :id, :starttime, :endtime, :duration, :linac_id, :created_by_user_id, :description
  json.url event_url(event, format: :json)
end
