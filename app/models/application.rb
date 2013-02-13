class Application < ActiveRecord::Base
  attr_accessible :description, :name, :dependencies_attributes

  has_many :dependencies

  accepts_nested_attributes_for :dependencies

  private

  def generate_token
    self.token = SecureRandom.hex(64)
  end

  before_create :generate_token
end
