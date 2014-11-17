json.array!(@accounts) do |account|
  json.extract! account, :id, :user_id, :provider, :oauth_token, :oauth_secret
  json.url account_url(account, format: :json)
end
