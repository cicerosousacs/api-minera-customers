require "test_helper"

class Api::V1::AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get sign_in" do
    get api_v1_auth_sign_in_url
    assert_response :success
  end

  test "should get sign_out" do
    get api_v1_auth_sign_out_url
    assert_response :success
  end

  test "should get change_password" do
    get api_v1_auth_change_password_url
    assert_response :success
  end
end
