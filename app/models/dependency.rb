class Dependency < ActiveRecord::Base
  attr_accessible :name, :version

  belongs_to :application

  default_scope order("name ASC")

  private

  validates :name, :uniqueness => {:scope => :application_id}, :presence => true
  validates :version, :presence => true
end
