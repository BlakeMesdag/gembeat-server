class Dependency < ActiveRecord::Base
  attr_accessible :name, :version

  belongs_to :application
  has_many :vulnerability_assessments
  has_many :vulnerabilities, :foreign_key => :dependency_name, :primary_key => :name

  default_scope order("name ASC")

  def assess_vulnerabilities
    Vulnerability.where(:dependency_name => name).each do |vulnerability|
      vulnerable = vulnerability.assess_dependency(self)

      assessment = vulnerability_assessments.where(:vulnerability_id => vulnerability.id).first
      assessment ||= vulnerability_assessments.new(:vulnerability_id => vulnerability.id)

      assessment.vulnerable = vulnerable
      assessment.save if assessment.changed?
    end
  end

  private

  validates :name, :uniqueness => {:scope => :application_id}, :presence => true
  validates :version, :presence => true
end
