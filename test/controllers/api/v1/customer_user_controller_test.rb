require "test_helper"

class Api::V1::CustomerUserControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get api_v1_customer_user_list_url
    assert_response :success
  end

  test "should get new" do
    get api_v1_customer_user_new_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_customer_user_update_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_customer_user_show_url
    assert_response :success
  end

  test "should get delete" do
    get api_v1_customer_user_delete_url
    assert_response :success
  end
end
