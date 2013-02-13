class Application < ActiveRecord::Base
  attr_accessible :description, :name, :token, :dependencies_attributes

  has_many :dependencies

  accepts_nested_attributes_for :dependencies
end
