require 'test_helper'

class DependenciesControllerTest < ActionController::TestCase
  def setup
    @controller.stubs(:authenticate).returns(nil)
    @dependency = dependencies(:gembeat_dependency)
  end

  test "index links to individual dependency" do
    get :index
    
    assert_response :ok
    assert_match "dependencies/#{@dependency.name}", response.body
  end

  test "index links to dependency and version" do
    get :index

    assert_match "dependencies/#{@dependency.name}?version=3.2.12", response.body
  end

  test "show loads dependency by name" do
    get :show, :id => "rails"

    assert_response :ok
  end

  test "show links to all applications with a dependency name" do
    get :show, :id => "rails"

    assert_select 'a[href*="/applications/"]', 2
  end

  test "show only links to applications with a given version" do
    get :show, id: "rails", version: "3.2.12"

    assert_select 'a[href*="/applications/"]', 1
  end
end
