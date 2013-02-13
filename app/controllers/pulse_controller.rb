class PulseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :load_application, :only => :create

  respond_to :json, :xml, :only => :create

  def create
    unless @application
      return render :json => {}, :status => 404
    end

    params[:application][:dependencies_attributes] = params[:application].delete(:dependencies)

    @application.update_attributes(params[:application])
    respond_with(@application)
  end

  private

  def load_application
    return unless params[:application]
    @application = Application.where(:token => params[:application].delete(:token).to_s).first
  end
end
