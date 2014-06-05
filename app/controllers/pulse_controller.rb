class PulseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :load_application, :only => :create

  respond_to :json, :xml, :only => :create

  def create
    unless @application
      return render_404
    end

    dependencies = params[:application].delete(:dependencies)
    @application.update_dependencies(dependencies)

    @application.update_attributes(params[:application])
    respond_with(@application)
  end

  private

  def load_application
    return unless params[:application]
    token = params[:application].delete(:token).to_s

    @application = Application.includes(:dependencies).where(token: token).first

    if !@application && ENV['REGISTRATION_TOKEN'] == params.fetch(:registration_token, nil)
      @application = Application.where(:name => params[:application][:name]).first_or_initialize
      @application.token = token
      @application.save!
    end
  end
end
