class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  def new_rider
    @user = User.new
  end

  def create_rider
    @user = User.new(rider_params)
    if @user.save
      flash[:notice] = "Your account was successfully created!"
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:error] = "Please be sure to include a name and a valid email."
      render :new
    end
  end

  def new_driver
    @user = User.new
  end

  def create_driver
    @user = User.new(driver_params)
    if @user.save
      @user.update!(role: 1)
      flash[:notice] = "Your account was successfully created!"
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:error] = "Please be sure to include a name and a valid email."
      render :new
    end
  end

  def show
  end

  private

  def rider_params
    params.require(:user).permit(:name, :email, :password, :phone_number, :password_confirmation)
  end

  def driver_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number, :car_make, :car_model, :car_capacity)
  end
end
