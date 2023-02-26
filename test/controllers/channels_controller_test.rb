require "test_helper"

class ChannelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @auth_headers = {headers: @user.create_new_auth_token.merge({accept: "application/json"})}
    @channel = channels(:one)
  end

  test "should get only the channels created by logged user" do
    get channels_url, as: :json, **@auth_headers
    parsed_body = JSON.parse(body)
    assert_equal parsed_body.count, 1
    assert_response :success
  end

  test "should create channel" do
    assert_difference("Channel.count") do
      post channels_url, params: {channel: {name: "Some Random Channel"}}, as: :json, **@auth_headers
    end

    assert_response :created
  end

  test "should show channel" do
    get channel_url(@channel), as: :json, **@auth_headers
    assert_response :success
  end

  test "should not show channel if logged user is not member or creator" do
    channel = channels(:two)
    get channel_url(channel), as: :json, **@auth_headers
    assert_response :forbidden
  end

  test "should update channel" do
    patch channel_url(@channel), params: {channel: {name: "Updated name"}}, as: :json, **@auth_headers
    assert_response :success
  end

  test "should not update channel if logged user is not the creator" do
    channel = channels(:two)
    patch channel_url(channel), params: {channel: {name: "Updated name"}}, as: :json, **@auth_headers
    assert_response :forbidden
  end

  test "should destroy channel" do
    assert_difference("Channel.count", -1) do
      delete channel_url(@channel), as: :json, **@auth_headers
    end

    assert_response :no_content
  end

  test "should not destroy the channel if logged user is not the creator" do
    channel = channels(:two)
    assert_difference("Channel.count", 0) do
      delete channel_url(channel), as: :json, **@auth_headers
    end

    assert_response :forbidden
  end
end
