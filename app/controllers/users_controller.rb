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
    @user = User.new
  end
end
