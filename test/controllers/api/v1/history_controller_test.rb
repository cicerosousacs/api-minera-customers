require "test_helper"

class Api::V1::HistoryControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get api_v1_history_list_url
    assert_response :success
  end
end
