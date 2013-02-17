require 'test_helper'

class DependencyTest < ActiveSupport::TestCase
  def setup
    @application = applications(:gembeat)
    @dependency = dependencies(:gembeat_dependency)
  end

  test "dependencies must have unique names per application" do
    assert_difference "Dependency.count", 0 do
      @application.dependencies.create(:name => @dependency.name, :version => "1.0.0")
    end
  end

  test "dependencies dont need unique names on different applications" do
    application = Application.create(:name => "test", :description => "test description")

    assert_difference "Dependency.count", 1 do
      application.dependencies.create(:name => @dependency.name, :version => "1.0.0")
    end
  end

  test "dependencies ordered by name by default" do
    @application.dependencies.create(:name => "zebra", :version => "1.0.0")
    @application.dependencies.create(:name => "apple", :version => "1.0.0")

    assert_equal ["apple", "rails", "zebra"], @application.dependencies.pluck(:name)
  end

  test "dependencies require a name" do
    assert_difference "Dependency.count", 0 do
      @application.dependencies.create(:version => "1.0.0")
    end
  end

  test "dependencies require a version" do
    assert_difference "Dependency.count", 0 do
      @application.dependencies.create(:name => "dwolla")
    end
  end
end
