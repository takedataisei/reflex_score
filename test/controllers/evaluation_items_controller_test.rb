require "test_helper"

class EvaluationItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get evaluation_items_index_url
    assert_response :success
  end
end
