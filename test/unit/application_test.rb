require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  test "A random token is generated on application create" do
    app = Application.create(name: "Test App", description: "An application for testing")

    assert_not_nil app.reload.token
  end

  test "Cannot mass-assign token on application" do
    assert_raises ActiveModel::MassAssignmentSecurity::Error do
      app = Application.create(name: "test app", description: "An application for testing", token: "123")
    end
  end
end
