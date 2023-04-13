require "test_helper"

class Api::V1::SleepRecordsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @sleep_record = create(:sleep_record, user: @user)
    @sleep_record_clock_in_only = create(:sleep_record, :clock_in_only, user: @user)
    @friend = create(:user)
    create(:follow, follower: @user, followee: @friend)
    create_list(:sleep_record, 5, user: @friend)
  end

  def authenticate_user
    {"Authorization" => @user.auth_token}
  end

  test "should create sleep record" do
    assert_difference("SleepRecord.count") do
      post api_v1_clock_in_path, headers: authenticate_user
    end

    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal "You are clocked in", json_response["message"]
    assert_not_nil json_response["data"]
  end

  test "should not create sleep record without authentication" do
    assert_no_difference("SleepRecord.count") do
      post api_v1_clock_in_path
    end

    assert_response :unauthorized
  end

  test "should update sleep record" do
    put api_v1_clock_out_path, headers: authenticate_user

    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal "You are clocked out", json_response["message"]
    @sleep_record_clock_in_only.reload
    assert_not_nil @sleep_record_clock_in_only.clock_out
  end

  test "should not update sleep record without authentication" do
    put api_v1_clock_out_path

    assert_response :unauthorized
  end

  test "should not get clocked-in times without authentication" do
    get api_v1_clock_ins_path

    assert_response :unauthorized
  end

  test "should get all clocked-in times ordered by created time" do
    get api_v1_clock_ins_path, headers: authenticate_user

    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_not_nil json_response["data"]
    assert_operator json_response["data"].length, :>, 0
    assert json_response["data"].each_cons(2).all? { |a, b| a["created_at"] <= b["created_at"] }
  end

  test "should get friend's sleep records over the past week ordered by duration" do
    get api_v1_feeds_path, headers: authenticate_user

    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_not_nil json_response["data"]
    assert_operator json_response["data"].length, :>, 0
    assert json_response["data"].each_cons(2).all? { |a, b| a["duration"] >= b["duration"] }
  end
end
