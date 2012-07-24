class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new params[:user]

    respond_to do |format|
      if @user.save
        sign_in @user
        flash[:success] = 'Welcome to Hypertasking!'
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

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    respond_to do |format|
      if @user.update_attributes params[:user]
        flash[:success] = 'You successfully updated your profile.'
        format.js {
          render js: "window.location.replace('#{user_path(@user)}')"
        }
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
end
