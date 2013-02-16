class Dependency < ActiveRecord::Base
  attr_accessible :name, :version

  belongs_to :application

  default_scope order("name ASC")
end
