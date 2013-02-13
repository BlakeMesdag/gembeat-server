class Dependency < ActiveRecord::Base
  attr_accessible :build, :major_version, :minor_version, :name, :version

  belongs_to :application

  private

  def update_versions
    versions = version.split(".")

    self.major_version = versions[0]
    self.minor_version = versions[1]
    self.build = versions.count > 3 ? versions.drop(2).join(".") : versions[2]
  end

  before_save :update_versions
end
