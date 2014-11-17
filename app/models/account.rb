class Account < ActiveRecord::Base
	belongs_to :user

	def search_twitter_followers
		return if provider != "twitter"
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV['TWITTER_KEY']
		  config.consumer_secret     = ENV['TWITTER_SECRET']
		  config.access_token        = oauth_token
		  config.access_token_secret = oauth_secret
		end
	end

	def search_facebook_friends
		@client = Koala::Facebook::API.new(oauth_token)
	end

	def instagram_client
		@client = Instagram.client(:access_token => oauth_token)
	end

	def list_instagram_followers
		instagram_client.user_search(name)
	end



	def search_ig(name)
		instagram_client.user_search(name, { :count => 1 })
	end

	def unfollow(userid)
		instagram_client.unfollow_user(userid)
	end

end

