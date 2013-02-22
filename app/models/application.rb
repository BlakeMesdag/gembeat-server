class Application < ActiveRecord::Base
  attr_accessible :description, :name, :github_url

  has_many :dependencies, dependent: :delete_all

  def update_dependencies(values)
    dependency_names = values.map {|v| v["name"]}

    values.each do |value|
      current_dependency = dependencies.where(:name => value["name"]).first
      current_dependency ||= dependencies.new(:name => value["name"], :version => value["version"])

      current_dependency.version = value["version"] if current_dependency.version != value["version"]

      current_dependency.save!
    end

    dependencies.where("dependencies.name NOT IN (?)", dependency_names).delete_all

    touch
  end

  def generate_token
    self.token = SecureRandom.hex(32)
  end

  def assess_dependencies_for_vulnerabilities
    dependencies.each do |dependency|
      dependency.assess_vulnerabilities
    end
  end

  private

  validates :name, :uniqueness => true

  before_create :generate_token
end
