class SessionsController < ApplicationController
  def new
    if signed_in?
      flash[:info] = "You're already signed in!"
      redirect_to current_user
    end
  end

  def create
    user = User.find_by_email params[:session][:email]
    respond_to do |format|
      if user
        if user.authenticate params[:session][:password]
          sign_in user
          flash[:success] = 'Welcome back, ' + user.first_name + '.'
          format.js {
            render js: "window.location.replace('#{user_path(user)}')"
          }
        else
          format.js {
            render template: 'shared/ujs/form_errors.js.erb',
            locals: {
              ids: ['password'],
              full_messages: ['Wrong password.']
            }
          }
        end
      else
        format.js {
          render template: 'shared/ujs/form_errors.js.erb',
          locals: {
            ids: ['email'],
            full_messages: ['No user with that email exists.']
          }
        }
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
