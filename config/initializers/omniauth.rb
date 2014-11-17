Rails.application.config.middleware.use OmniAuth::Builder do
	provider :developer unless Rails.env.production?

 	provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
	provider :facebook, "645692765514684", "1e8436ac43ee8ff586c10cb626047777"
	

	provider :instagram, ENV['INSTAGRAM_KEY'], ENV['INSTAGRAM_SECRET']


end