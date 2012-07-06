class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new params[:user]
    @user.save

    respond_to do |format|
      format.js
    end
  end

  def new
    @user = User.new
  end
end
