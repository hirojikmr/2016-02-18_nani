require 'test_helper'

class CapselsControllerTest < ActionController::TestCase
  setup do
    @capsel = capsels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:capsels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create capsel" do
    assert_difference('Capsel.count') do
      post :create, capsel: { end: @capsel.end, start: @capsel.start }
    end

    assert_redirected_to capsel_path(assigns(:capsel))
  end

  test "should show capsel" do
    get :show, id: @capsel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @capsel
    assert_response :success
  end

  test "should update capsel" do
    patch :update, id: @capsel, capsel: { end: @capsel.end, start: @capsel.start }
    assert_redirected_to capsel_path(assigns(:capsel))
  end

  test "should destroy capsel" do
    assert_difference('Capsel.count', -1) do
      delete :destroy, id: @capsel
    end

    assert_redirected_to capsels_path
  end
end
