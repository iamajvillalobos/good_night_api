require "test_helper"

class Api::V1::SleepRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @sleep_record = sleep_records(:one)
    @sleep_record_clock_in_only = sleep_records(:clock_in_only)
  end

  def authenticate_user
    {"Authorization" => @user.auth_token}
  end

  test "should create sleep record" do
    assert_difference("SleepRecord.count") do
      post clock_in_url, headers: authenticate_user
    end

    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal "You are clocked in", json_response["message"]
    assert_not_nil json_response["data"]
  end

  test "should not create sleep record without authentication" do
    assert_no_difference("SleepRecord.count") do
      post clock_in_url
    end

    assert_response :unauthorized
  end

  test "should update sleep record" do
    put clock_out_url, headers: authenticate_user

    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal "You are clocked out", json_response["message"]
    @sleep_record_clock_in_only.reload
    assert_not_nil @sleep_record_clock_in_only.clock_out
  end

  test "should not update sleep record without authentication" do
    put clock_out_url

    assert_response :unauthorized
  end
end
