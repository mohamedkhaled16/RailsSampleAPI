json.extract! notification, :id, :token, :other, :created_at, :updated_at
json.url notification_url(notification, format: :json)