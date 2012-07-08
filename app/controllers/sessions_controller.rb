class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:session][:email]
    respond_to do |format|
      if user
        if user.authenticate params[:session][:password]
          sign_in user
          format.js
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
  end
end
