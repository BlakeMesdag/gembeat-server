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

  test "updating dependencies touches updated_at" do
    old_updated_at = @application.updated_at

    @application.update_dependencies([])

    assert_not_equal old_updated_at, @application.reload.updated_at
  end

  test "cannot create two applications with the same name" do
    assert_difference "Application.count", 0 do
      Application.create(:name => @application.name)
    end
  end

  test "assess_vulnerabilities returns a list of vulernability_assessments" do
    assert_difference "VulnerabilityAssessment.count", 1 do
      @application.assess_dependencies_for_vulnerabilities
    end
  end
end
