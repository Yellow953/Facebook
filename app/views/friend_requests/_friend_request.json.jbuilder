json.extract! friend_request, :id, :from, :to, :created_at, :updated_at
json.url friend_request_url(friend_request, format: :json)
