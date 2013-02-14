class ApplicationsController < ApplicationController
  before_filter :authenticate

  before_filter :load_application, except: [:index, :create, :new]

  OPERATORS = {"=" => "=", ">" => ">", "<" => "<"}

  def index
    @applications = Application.includes(:dependencies)

    @applications = @applications.where(dependencies: {name: params[:gem].to_s}) unless params[:gem].blank?
    if !params[:version].blank? && !params[:operator].present?
      @applications = @applications.where(dependencies: {version: params[:version].to_s})
    elsif !params[:version].blank? && params[:operator].present?
      operator = OPERATORS["#{params[:operator]}"]
      @applications = @applications.where("dependencies.version #{operator} ?", params[:version]) if !operator.blank?
    end

    @operators = [["=","="],[">",">"],["<","<"]]
  end

  def show
  end

  def new
  end

  def create
    @application = Application.create(params[:application])

    redirect_to url_for(@application)
  end

  def edit
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
