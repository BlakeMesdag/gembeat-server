class Dependency < ActiveRecord::Base
  attr_accessible :name, :version

  belongs_to :application
end
