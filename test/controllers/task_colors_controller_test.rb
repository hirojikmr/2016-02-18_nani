require 'test_helper'

class TaskColorsControllerTest < ActionController::TestCase
  setup do
    @task_color = task_colors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_colors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_color" do
    assert_difference('TaskColor.count') do
      post :create, task_color: { color: @task_color.color, text: @task_color.text }
    end

    assert_redirected_to task_color_path(assigns(:task_color))
  end

  test "should show task_color" do
    get :show, id: @task_color
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task_color
    assert_response :success
  end

  test "should update task_color" do
    patch :update, id: @task_color, task_color: { color: @task_color.color, text: @task_color.text }
    assert_redirected_to task_color_path(assigns(:task_color))
  end

  test "should destroy task_color" do
    assert_difference('TaskColor.count', -1) do
      delete :destroy, id: @task_color
    end

    assert_redirected_to task_colors_path
  end
end
