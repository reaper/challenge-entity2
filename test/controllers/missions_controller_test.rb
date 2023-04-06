require "test_helper"

class MissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mission = create(:mission)
  end

  test "should get index" do
    get missions_url
    assert_response :success
  end
end
