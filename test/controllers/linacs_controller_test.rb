require 'test_helper'

class LinacsControllerTest < ActionController::TestCase
  setup do
    @linac = linacs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:linacs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create linac" do
    assert_difference('Linac.count') do
      post :create, linac: { name: @linac.name, user_group_id: @linac.user_group_id }
    end

    assert_redirected_to linac_path(assigns(:linac))
  end

  test "should show linac" do
    get :show, id: @linac
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @linac
    assert_response :success
  end

  test "should update linac" do
    patch :update, id: @linac, linac: { name: @linac.name, user_group_id: @linac.user_group_id }
    assert_redirected_to linac_path(assigns(:linac))
  end

  test "should destroy linac" do
    assert_difference('Linac.count', -1) do
      delete :destroy, id: @linac
    end

    assert_redirected_to linacs_path
  end
end
