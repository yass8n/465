require 'test_helper'

class DoiObjectsControllerTest < ActionController::TestCase
  setup do
    @doi_object = doi_objects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:doi_objects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create doi_object" do
    assert_difference('DoiObject.count') do
      post :create, doi_object: { description: @doi_object.description, name: @doi_object.name }
    end

    assert_redirected_to doi_object_path(assigns(:doi_object))
  end

  test "should show doi_object" do
    get :show, id: @doi_object
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @doi_object
    assert_response :success
  end

  test "should update doi_object" do
    patch :update, id: @doi_object, doi_object: { description: @doi_object.description, name: @doi_object.name }
    assert_redirected_to doi_object_path(assigns(:doi_object))
  end

  test "should destroy doi_object" do
    assert_difference('DoiObject.count', -1) do
      delete :destroy, id: @doi_object
    end

    assert_redirected_to doi_objects_path
  end
end
