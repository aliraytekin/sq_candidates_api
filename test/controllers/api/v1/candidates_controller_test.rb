require "test_helper"

class Api::V1::CandidatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_candidates_index_url
    assert_response :success
  end
end
