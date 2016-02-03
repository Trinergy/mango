class Admin::UsersController < ApplicationController
  before_action :is_admin?

  def is_admin?
    redirect_to movies_path unless current_user.admin?
  end

  def index
    @users = User.order(:lastname).page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(
      :firstname, :lastname, :email
    )
  end

end
