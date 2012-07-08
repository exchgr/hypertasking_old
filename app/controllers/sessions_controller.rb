class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:session][:email]
    respond_to do |format|
      if !user
        format.js {
          render template: 'shared/ujs/form_errors.js.erb',
          locals: {
            ids: ['email'],
            full_messages: ['No user with that email exists.']
          }
        }
      elsif !user.authenticate params[:session][:password]
        format.js {
          render template: 'shared/ujs/form_errors.js.erb',
          locals: {
            ids: ['email'],
            full_messages: ['Wrong password.']
          }
        }
      end
    end
  end

  def destroy
  end
end
