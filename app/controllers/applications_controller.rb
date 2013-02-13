class ApplicationsController < ApplicationController
  before_filter :authenticate

  before_filter :load_application, :except => [:index, :create, :new]

  def index
  end

  def show
  end

  def new
  end

  def create
    @application = Application.create(params[:application])

    redirect_to url_for(@application)
  end

  def update
    @application.update_attributes(params[:application])

    redirect_to url_for(@application)
  end

  def destroy
    @application.destroy

    redirect_to action: :index
  end

  private

  def load_application
    @application = Application.find(params[:id].to_i)
  end
end
