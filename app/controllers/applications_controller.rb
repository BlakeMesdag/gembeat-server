class ApplicationsController < ApplicationController
  before_filter :authenticate

  before_filter :load_application, only: [:show, :edit, :update, :destroy]

  OPERATORS = {"=" => "=", ">" => ">", "<" => "<", "" => "="}

  def index
    @applications = Application.includes(:dependencies)

    @applications = @applications.where(dependencies: {name: params[:gem].to_s}) unless params[:gem].blank?
    if !params[:version].blank?
      operator = OPERATORS[params[:operator].to_s]
      @applications = @applications.where("dependencies.version #{operator} ?", params[:version].to_s) if !operator.blank?
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
    @application = Application.where(id: params[:id].to_i).first

    return render_404 unless @application
  end
end
