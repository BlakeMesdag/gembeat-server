class SessionsController < ApplicationController
  skip_before_filter :authenticate, :verify_authenticity_token

  def new
    redirect_to '/auth/google'
  end

  def create
    redirect_to = session[:redirect_to]
    reset_session

    if auth = request.env['omniauth.auth']
      session[:active] = true
      redirect_to redirect_to.nil? ? "/" : redirect_to
    end
  end
end
