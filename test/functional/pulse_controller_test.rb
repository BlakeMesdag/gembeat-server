require 'test_helper'

class PulseControllerTest < ActionController::TestCase
  def setup
    @application = applications(:gembeat)
  end

  test "post to create rejected without application token" do
    post :create, :format => :json
    assert_response :not_found
  end

  test "post to create with application token updates dependencies" do
    @application.dependencies.destroy_all

    post :create, {application: { token: "testtoken", dependencies: [{name: "rake", version: "1.4.5"}]}}, format: "json"

    @application.reload

    assert_equal "rake", @application.dependencies.first.name
    assert_equal "1.4.5", @application.dependencies.first.version
    assert_equal 1, @application.dependencies.count
  end

end
