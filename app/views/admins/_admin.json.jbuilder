json.extract! admin, :id, :nome, :email, :password, :created_at, :updated_at
json.url admin_url(admin, format: :json)
