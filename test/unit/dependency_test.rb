require 'test_helper'

class DependencyTest < ActiveSupport::TestCase
  def setup
    @dependency = dependencies(:gembeat_depency)
  end

  test "updating versions populates the major version" do
    @dependency.version = "5.4.3"
    @dependency.save

    assert_equal 5, @dependency.major_version
  end

  test "updating versions populates the minor version" do
    @dependency.version = "5.4.3"
    @dependency.save

    assert_equal 4, @dependency.minor_version
  end

  test "updating versions populates the build version" do
    @dependency.version = "5.4.3"
    @dependency.save

    assert_equal 3, @dependency.build
  end

  test "extended versions get packed into build" do
    @dependency.version = "5.4.3.5"
    @dependency.save

    assert_equal 3.5, @dependency.build
  end
end
