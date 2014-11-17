class UsersController < ApplicationController
 def index

  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:notice] = "User updated!"
      redirect_to user_path(@user)
    else
      flash[:notice] = "Failed to update user"
      redirect_to edit_user_path(@user)
    end
  end

  def create
    @user = User.create( user_params )

    if @user 
      flash[:alert] = "Signed up successfully!"
      redirect_to user_path(@user) 
    else
      flash[:alert] = "Oops! Something went wrong!"
      redirect_to new_user_path
    end
  end

  def show
  	@user = User.find(params[:id])
  end

  def destroy
  	@user = User.find(params[:id])
	  if @user.destroy
  		flash[:notice] = "User deleted successfully."
    else
  		flash[:alert] = "There was a problem."
 	  end
 		redirect_to users_path
  end

  private
  def user_params
    params.require(:user).
      permit(:first_name, :last_name, :email, :username, :password)
  end
end
