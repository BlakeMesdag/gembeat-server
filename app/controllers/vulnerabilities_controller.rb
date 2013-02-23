class VulnerabilitiesController < ApplicationController
  before_filter :authenticate
  before_filter :load_vulnerability, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @vulnerabilities = Vulnerability.all
  end

  def show
  end

  def new
    @vulnerability = Vulnerability.new
  end

  def create
    params[:vulnerability][:versions] = params[:vulnerability][:versions].split(",").map(&:strip)

    @vulnerability = Vulnerability.create(params[:vulnerability])

    redirect_to url_for(@vulnerability)
  end

  def edit
  end

  def update
    @vulnerability.update_attributes(params[:vulnerability])

    redirect_to url_for(@vulnerability)
  end

  def destroy
    @vulnerability.destroy

    redirect_to vulnerabilities_url
  end

  private

  def load_vulnerability
    @vulnerability = Vulnerability.where(id: params[:id].to_i).first

    return render_404 unless @vulnerability
  end
end
