class UserSessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  
  def new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to root_path, notice: "You have logged in"
    else 
      flash.now[:alert] = "Login Failed"
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "You have logged out"
  end
end
