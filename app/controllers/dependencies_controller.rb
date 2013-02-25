class DependenciesController < ApplicationController
  before_filter :authenticate

  def index
    dependencies = Dependency.select(:name).uniq
    dependencies = dependencies.where(version: params[:version].to_s) if params[:version]
    dependency_names = dependencies.map(&:name)

    @dependencies = dependency_names.map do |name|
      {
        :name => name,
        :versions => Dependency.select([:id, :name,:version]).uniq.where(:name => name).map do |d|
          "<a href=\"#{url_for(action: :show, id: d.name, version: d.version)}\" #{"class=\"vulnerable\"" if d.vulnerable?}>#{d.version}</a>"
        end
      }
    end
  end

  def show
    @dependencies = Dependency.includes(:application).where(name: params[:id].to_s)
    @dependencies = @dependencies.where(version: params[:version].to_s) if params[:version]
  end
end
