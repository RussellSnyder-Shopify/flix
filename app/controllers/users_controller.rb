class UsersController < ApplicationController
  before_action :require_signin, except: %i[new create]
  before_action :require_correct_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Thanks for signing up!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User Updated!'
    else
      render :new
    end
  end

  def destroy
    @user.destroy

    session[:user_id] = nil

    redirect_to movies_path, alert: 'Account Deleted'
  end

  private

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to movies_url unless current_user?(@user)
  end

  def user_params
    params.require(:user)
          .permit(:name, :username, :email, :password, :password_confirmation)
  end
end
