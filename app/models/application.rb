class Application < ActiveRecord::Base
  attr_accessible :description, :name, :dependencies_attributes

  has_many :dependencies, :dependent => :delete_all

  accepts_nested_attributes_for :dependencies

  def update_dependencies(values)
    dependency_names = []
    values.each do |value|
      dependency_names << value["name"]

      current_dependency = dependencies.where(:name => value["name"]).first
      current_dependency ||= dependencies.new(:name => value["name"], :version => value["version"])

      current_dependency.version = value["version"] if current_dependency.version != value["version"]

      current_dependency.save!
    end

    dependencies.where("dependencies.name NOT IN (?)", dependency_names).delete_all

    touch
  end

  private

  def generate_token
    self.token = SecureRandom.hex(32)
  end

  before_create :generate_token
end
