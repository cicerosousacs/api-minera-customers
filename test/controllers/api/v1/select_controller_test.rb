require "test_helper"

class Api::V1::SelectControllerTest < ActionDispatch::IntegrationTest
  test "should get cnaes" do
    get api_v1_select_cnaes_url
    assert_response :success
  end

  test "should get company_size" do
    get api_v1_select_company_size_url
    assert_response :success
  end

  test "should get municipality_from_uf" do
    get api_v1_select_municipality_from_uf_url
    assert_response :success
  end

  test "should get district_from_municipality" do
    get api_v1_select_district_from_municipality_url
    assert_response :success
  end
end
