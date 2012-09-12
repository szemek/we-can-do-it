class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.present?
      redirect_to({ :controller => params[:controller], :action => :index }, :notice => exception.message)
    else
      redirect_to login_path, :notice => exception.message
    end
  end

  def current_user
    @current_user = User.find_by_id(session[:user_id])
  end
  helper_method :current_user
end
