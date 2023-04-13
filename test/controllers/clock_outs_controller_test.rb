require "test_helper"

class Api::V1::ClockOutsControllerTest < ActionDispatch::IntegrationTest
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
end
