class Dependency < ActiveRecord::Base
  attr_accessible :build, :major_version, :minor_version, :name, :version

  belongs_to :application
end
