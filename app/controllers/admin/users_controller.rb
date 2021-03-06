class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:archive,:show, :edit, :update, :destroy]
  before_action :set_projects, only: [:new,:create,:edit,:update]
  def index
    @users = User.excluding_archived.order(:email)
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def update
    ss
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end
    if @user.update(user_params)
     flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been updated."
      render "edit"
    end
  end

  def create
    ss
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been created."
      render new
    end
  end

  def archive
    if @user == current_user
      flash[:alert] = "You can't archive yourself."
      redirect_to admin_users_path
    else
      @user.archive
      flash[:notice] = "User has been archived."
      redirect_to admin_users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:email,:password,:admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_projects
    @projects = Project.order(:name)
  end


end
