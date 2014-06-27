class SessionsController < ApplicationController
  def create
    user = User.find_or_create_by(basic_user_attributes)

    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  protected

    def basic_user_attributes
      {
        provider: auth['provider'],
        username: auth['info']['nickname']
      }
    end

    def auth
      request.env['omniauth.auth']
    end
end
