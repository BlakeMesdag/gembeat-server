require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase
  def setup
    @application = applications(:gembeat)
    @controller.stubs(:authenticate).returns(nil)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @application.id
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "posts to create creates an application" do
    assert_difference "Application.count", 1 do
      post :create, application: { name: "Super Tool" }
      assert_response :redirect 
    end
  end

  test "put to update updates an application" do
    put :update, id: @application.id, application: { name: "Super Duper Tool" }
    assert_redirected_to action: :show, id: @application.id

    assert_equal "Super Duper Tool", @application.reload.name
  end

  test "destroy removes an application" do
    assert_difference "Application.count", -1 do
      post :destroy, id: @application.id
      assert_redirected_to action: :index
    end
  end

end
