class SearchController < ApplicationController
  def index
  end

 # def search
 #  @query = params[:query]
 #  @users = User.where("(first_name || last_name) LIKE ?", "%#{@query}%")	
 # end

  def list
	@users = current_user.accounts.where(provider: "instagram").first.list_instagram_followers
  end

  def do_search
  	@users = current_user.accounts.where(provider: "instagram").first.search_ig(params[:search])
  end

  def do_unfollow
  	@unfollowed = current_user.accounts.where(provider: "instagram").first.unfollow(params[:userid])
  end

end
