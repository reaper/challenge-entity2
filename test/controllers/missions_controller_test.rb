require "test_helper"

class MissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mission = create(:mission)
  end

  test "should get index" do
    get missions_url
    assert_response :success
  end

  ## JSON

  test "should get index with json" do
    get missions_url, as: :json
    assert_response :success
    assert response.parsed_body.has_key?("missions")
    assert response.parsed_body["missions"].first.is_a?(Hash)
    assert response.parsed_body["missions"].first["id"].present?
    assert response.parsed_body["missions"].first["mission_type"].present?
    assert response.parsed_body["missions"].first["listing_id"].present?
    assert response.parsed_body["missions"].first["date"].present?
    assert response.parsed_body["missions"].first["price"].present?
  end
end
