require "test_helper"

class Api::V1::SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get api_v1_search_search_url
    assert_response :success
  end
end
