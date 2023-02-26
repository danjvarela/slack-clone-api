require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @auth_headers = {headers: @user.create_new_auth_token.merge({accept: "application/json"})}
    @message = messages(:one)
  end

  test "should get all messages associated with logged user" do
    get messages_url, as: :json, **@auth_headers
    parsed_body = JSON.parse(body)
    assert_equal parsed_body.count, 2
    assert_response :success
  end

  test "should send message to another user" do
    receiver = users(:two)
    assert_difference("@user.reload.messages.count", 1) do
      post messages_url, params: {message: {receiver_id: receiver.id, receiver_type: "User", body: "hello"}}, as: :json, **@auth_headers
    end
    assert_response :created
  end

  test "should send message to a channel the logged user has created or joined" do
    receiver = channels(:one)
    assert_difference("@user.reload.messages.count", 1) do
      post messages_url, params: {message: {receiver_id: receiver.id, receiver_type: "Channel", body: "hello"}}, as: :json, **@auth_headers
    end
    assert_response :created
  end

  test "should not send a message to a channel the logged user is not associated with" do
    receiver = channels(:two)
    assert_difference("@user.reload.messages.count", 0) do
      post messages_url, params: {message: {receiver_id: receiver.id, receiver_type: "Channel", body: "hello"}}, as: :json, **@auth_headers
    end
    assert_response :unprocessable_entity
  end

  test "should show message" do
    get message_url(@message), as: :json, **@auth_headers
    assert_response :success
  end

  test "should not show message details if logged user is not associated with it" do
    message = messages(:three)
    get message_url(message), as: :json, **@auth_headers
    assert_response :forbidden
  end

  test "should update message" do
    patch message_url(@message), params: {message: {body: "updated"}}, as: :json, **@auth_headers
    assert_response :success
  end

  test "should not update message if logged user is not the sender" do
    message = messages(:three)
    patch message_url(message), params: {message: {body: "updated"}}, as: :json, **@auth_headers
    assert_response :forbidden
  end

  test "should destroy message" do
    assert_difference("@user.reload.messages.count", -1) do
      delete message_url(@message), as: :json, **@auth_headers
    end

    assert_response :no_content
  end

  test "should not destroy message if logged user is not the sender" do
    message = messages(:three) 
    assert_difference("@user.reload.messages.count", 0) do
      delete message_url(message), as: :json, **@auth_headers
    end

    assert_response :forbidden
  end
end
