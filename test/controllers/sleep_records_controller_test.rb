require "test_helper"

class SleepRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get sleep_records_create_url
    assert_response :success
  end

  test "should get update" do
    get sleep_records_update_url
    assert_response :success
  end
end
