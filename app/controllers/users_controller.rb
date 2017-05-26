class UsersController < ApplicationController
  before_action :is_not_fake, except: [:new, :create]

  def index
    redirect_to signup_path
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.password == user.password_confirmation
      user.save
      session[:user_id] = user.id
      flash[:notice] = "Thanks for signing up #{user.name}!"
      redirect_to user_path(user)
    else
      flash.now[:notice] = "Something went horribly wrong. Please reenter your information."
      redirect_to signup_path
    end

  end

  def show
    @user = User.find(params[:id])
    if session[:user_id] != @user.id
      redirect_to :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

end
