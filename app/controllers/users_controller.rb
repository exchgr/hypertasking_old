class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]

  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new params[:user]

    respond_to do |format|
      if @user.save
        sign_in @user
        flash[:success] = 'Welcome to Hypertasking!'
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

  def new
    if signed_in?
      flash[:info] = "You're already signed in!"
      redirect_to current_user
    else
      @user = User.new
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes params[:user]
        sign_in @user
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

  private

  def signed_in_user
    unless signed_in?
      flash[:error] = 'You need to be signed in to do that.'
      redirect_to signin_path
    end
  end

  def correct_user
    @user = User.find params[:id]
    unless current_user? @user
      flash[:error] = 'Authorized personnel only.'
      redirect_to root_path
    end
  end
end
