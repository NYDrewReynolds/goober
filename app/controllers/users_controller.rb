class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Your account was successfully created!"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = "Please be sure to include a name and a valid email."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :email, :password, :password_confirmation)
  end
end
