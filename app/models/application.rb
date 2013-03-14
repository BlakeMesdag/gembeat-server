class Application < ActiveRecord::Base
  attr_accessible :description, :name, :github_url

  has_many :dependencies, dependent: :delete_all
  has_many :vulnerability_assessments, dependent: :delete_all

  default_scope order("name ASC")

  def update_dependencies(values)
    dependency_names = values.map {|v| v["name"]}
    dependency_hash = {}
    values.each {|d| dependency_hash[d["name"]] = d["value"]}

    current_dependencies = dependencies.where(name: dependency_names)
    current_dependencies.each do |dependency|
      next unless dependency_hash[dependency.name]

      dependency.version = dependency_hash[dependency.name]
      dependency.save! if dependency.changed?
    end

    current_dependency_names = current_dependencies.map(&:name)
    new_dependencies = values.reject {|v| current_dependency_names.include?(v["name"])}

    dependencies.create(new_dependencies)

    dependencies.where("dependencies.name NOT IN (?)", dependency_names).destroy_all

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

  def vulnerable?
    @vulnerable ||= vulnerability_assessments.where(vulnerable: true).any?
  end

  private

  validates :name, :uniqueness => true

  before_create :generate_token
end
