class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate
    session[:redirect_to] = request.path
    redirect_to '/login' unless session[:active]
  end
end
