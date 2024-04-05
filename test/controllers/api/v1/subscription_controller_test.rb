require "test_helper"

class Api::V1::SubscriptionControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get api_v1_subscription_list_url
    assert_response :success
  end
end
