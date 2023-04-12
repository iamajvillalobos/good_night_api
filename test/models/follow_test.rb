require "test_helper"

class Api::V1::FollowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
  end

  test "should create follow" do
    assert_difference("@user.followees.count", 1) do
      post follow_path(@other_user.id), headers: {"Authorization" => @user.auth_token}
    end
    assert_response :created
  end

  test "should not create duplicate follow" do
    post follow_path(@other_user.id), headers: {"Authorization" => @user.auth_token}
    assert_no_difference("@user.followees.count") do
      post follow_path(@other_user.id), headers: {"Authorization" => @user.auth_token}
    end
    assert_response :unprocessable_entity
  end

  test "should destroy follow" do
    post follow_path(@other_user.id), headers: {"Authorization" => @user.auth_token}
    assert_difference("@user.followees.count", -1) do
      delete unfollow_path(@other_user.id), headers: {"Authorization" => @user.auth_token}
    end
    assert_response :ok
  end

  test "should not destroy non-existent follow" do
    assert_no_difference("@user.followees.count") do
      delete unfollow_path(@other_user.id), headers: {"Authorization" => @user.auth_token}
    end
    assert_response :unprocessable_entity
  end
end
