class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate
    session[:redirect_to] = request.path
    redirect_to '/login' unless session[:active]
  end

  def render_404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false}
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
end
