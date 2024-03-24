require "test_helper"

class Api::V1::ExportControllerTest < ActionDispatch::IntegrationTest
  test "should get export_to_xlsx" do
    get api_v1_export_export_to_xlsx_url
    assert_response :success
  end
end
