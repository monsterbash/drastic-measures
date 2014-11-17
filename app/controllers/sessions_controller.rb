class SessionsController < ApplicationController
  def new
  	#render the form
  end

  def create
    auth_hash = request.env["omniauth.auth"]
    p auth_hash.inspect
    # p auth_hash[:email]
    p auth_hash[:credentials][:token]
    case params[:provider]
    when "facebook"
      @account = Account.where(provider: "facebook", uid: auth_hash[:uid]).first_or_initialize
      
      @account.oauth_token = auth_hash[:credentials][:token]
      if @account.persisted?
        @user = @account.user
   
      else
        @user = User.create(email: auth_hash[:info][:email], first_name: auth_hash[:info][:first_name], last_name: auth_hash[:info][:last_name])
        @account.user_id = @user.id
        @account.save
      end
      session[:user_id] = @user.id
      flash[:notice] = "Signed in successfully."
      redirect_to home_page_path

    when "twitter"
      @account = Account.where(provider: "twitter", oauth_token: auth_hash[:credentials][:token], oauth_secret: auth_hash[:credentials][:secret], user_id: current_user.id).first_or_initialize
      if @account.persisted? && @account.save
        flash[:notice] = "Connected to Twitter successfully."
        redirect_to home_page_path
      else
        flash[:notice] = "There was a problem connecting to Twitter."
        redirect_to home_page_path
      end

    when "instagram"
      @account = Account.where(provider: "instagram",
        oauth_token: auth_hash[:credentials][:token],
        oauth_secret: auth_hash[:credentials][:secret],
        user_id: current_user.id).first_or_initialize
      if @account.persisted?@ && @account.save
        flash[:notice] = "Connected to Instagram successfully."
        redirect_to home_page_path
      else
        flash[:notice] = "There was a problem connecting to Instagram."
        redirect_to home_page_path
      end

    
    else
      throw StandardError
    end

  end

  def destroy
  	session[:user_id] = nil
    redirect_to home_page_path
  end

  private
  def user_params
  	params.require(:user).
  		permit(:first_name, :last_name, :email, :username, :password)
  end
end
