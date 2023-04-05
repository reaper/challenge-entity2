require "test_helper"

class MissionTest < ActiveSupport::TestCase
  test "create first_checkin mission" do
    mission = create :mission, :first_checkin
    assert mission.persisted?
    assert mission.missionable.is_a?(Booking)
    assert_equal mission.price.to_i, 20
  end

  test "create last_checkout mission" do
    mission = create :mission, :last_checkout
    assert mission.persisted?
    assert mission.missionable.is_a?(Booking)
    assert_equal mission.price.to_i, 10
  end

  test "create checkout_checkin mission" do
    mission = create :mission, :checkout_checkin
    assert mission.persisted?
    assert mission.missionable.is_a?(Reservation)
    assert_equal mission.price.to_i, 20
  end

  test "booking can be canceled" do
    mission = create :mission
    mission.cancel!
    assert mission.canceled?
  end
end
