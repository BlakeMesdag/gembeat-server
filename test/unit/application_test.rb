require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  def setup
    @application = applications(:gembeat)
  end

  test "A random token is generated on application create" do
    app = Application.create(name: "Test App", description: "An application for testing")

    assert_not_nil app.reload.token
  end

  test "Cannot mass-assign token on application" do
    assert_raises ActiveModel::MassAssignmentSecurity::Error do
      app = Application.create(name: "test app", description: "An application for testing", token: "123")
    end
  end

  test "when updating dependencies old ones should be deleted" do
    @application.update_dependencies([{"name" => "rake", "version" => "10.0.3"}])

    assert_equal 1, @application.dependencies.count
    assert_equal "rake", @application.dependencies.first.name
  end
end
