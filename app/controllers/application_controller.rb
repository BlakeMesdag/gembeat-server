class ApplicationController < ActionController::Base
  protect_from_forgery

  def fix_clobbered_params
    params = params.with_indifferent_access
  end

  def authenticate
    session[:redirect_to] = request.path
    redirect_to '/login' unless session[:active]
  end
end
