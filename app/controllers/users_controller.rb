class UsersController < ApplicationController

  def new_rider
    @user = User.new(rider_params)
  end

  def create_rider
    @user = User.new(rider_params)
    if @user.save
      flash[:notice] = "Your account was successfully created!"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = "Please be sure to include a name and a valid email."
      render :new
    end
  end

  def new_driver
    @user = User.new(driver_params)
  end

  def create_driver
    @user = User.new(driver_params)
    if @user.save
      flash[:notice] = "Your account was successfully created!"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = "Please be sure to include a name and a valid email."
      render :new
    end
  end

  def show
    
  end

  private

  def rider_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def driver_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :car_make, :car_model, :car_capacity)
  end
end
