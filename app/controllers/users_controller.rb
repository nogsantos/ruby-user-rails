class UsersController < ApplicationController
  # before_action :set_task, only: [:show, :edit, :update, :destroy]
  respond_to :xml, :json

  def index
    @user = User.all
    respond_with(@user)
  end
  
  def new
    @user = User.new 
  end
  
  def create
    # puts(params[:user])
    respond_with @user = User.create(user_params)    
  end  

  def update
    @user.update(user_params)
    respond_with @user
  end
  
  def destroy
    @user = User.find params[:id]
    @user.destroy
    respond_with(@user)
  end

  def show
    @user = User.find params[:id]
    respond_with(@user)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :username, :status)
  end

end
