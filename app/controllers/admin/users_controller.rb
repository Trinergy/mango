class Admin::UsersController < ApplicationController
  before_action :is_admin?

  def is_admin?
    redirect_to movies_path unless current_user.admin?
  end

  def index
    @users = User.order(:lastname).page params[:page]
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  protected

  def user_params
    params.require(:user).permit(
      :firstname, :lastname, :email, :admin, :password, :password_confirmation
    )
  end

end
