require "test_helper"

class PeerEvaluationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get peer_evaluations_new_url
    assert_response :success
  end

  test "should get index" do
    get peer_evaluations_index_url
    assert_response :success
  end

  test "should get edit" do
    get peer_evaluations_edit_url
    assert_response :success
  end
end
