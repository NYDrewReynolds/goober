class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])
    if user
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:error] = "Invalid Login"
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    flash[:notice] = "Logout Successful"
    redirect_to root_path
  end
end
