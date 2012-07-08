class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new params[:user]
    @user.save

    respond_to do |format|
      if @user.save
        sign_in @user
        format.js
      else
        format.js {
          render template: 'shared/ujs/form_errors.js.erb',
          locals: {
            ids: @user.errors,
            full_messages: @user.errors.full_messages 
          }
        }
      end
    end
  end

  def new
    if signed_in?
      flash[:info] = "You're already signed in!"
      redirect_to current_user
    else
      @user = User.new
    end
  end
end
