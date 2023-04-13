require "test_helper"

class Api::V1::FeedsControllerTest < ActionDispatch::IntegrationTest
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

  test "should get friend's sleep records over the past week ordered by duration" do
    get api_v1_feeds_path, headers: authenticate_user

    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_not_nil json_response["data"]
    assert_operator json_response["data"].length, :>, 0
    assert json_response["data"].each_cons(2).all? { |a, b| a["duration"] >= b["duration"] }
  end
end
