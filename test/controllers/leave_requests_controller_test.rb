require 'test_helper'

class LeaveRequestsControllerTest < ActionController::TestCase
  setup do
    @leave_request = leave_requests(:one)
    session[:user] = Person.find_by_email("user1@example.com")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leave_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create leave_request" do
    assert_difference('LeaveRequest.count') do
      post :create, leave_request: { date: @leave_request.date + 1, leave_type: @leave_request.leave_type, requestor: @leave_request.requestor, status: @leave_request.status }
    end

    assert_redirected_to leave_request_path(assigns(:leave_request))
  end

  test "should show leave_request" do
    get :show, id: @leave_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @leave_request
    assert_response :success
  end

  test "should update leave_request" do
    patch :update, id: @leave_request, leave_request: { date: @leave_request.date + 1, leave_type: @leave_request.leave_type, requestor: @leave_request.requestor, status: @leave_request.status }
    assert_redirected_to leave_request_path(assigns(:leave_request))
  end

  test "should destroy leave_request" do
    assert_difference('LeaveRequest.count', -1) do
      delete :destroy, id: @leave_request
    end

    assert_redirected_to leave_requests_path
  end
end
