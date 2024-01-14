class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def login
  end

  def login_attempt
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      logger.error session[:user_id]
      redirect_to users_path
    else
      render :login, status: :unauthorized
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
  end

  def register
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :register, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :surname)
    end
end
