class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new params[:user]
    if @user.save
      #what to do?
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end
end
