require "test_helper"

class BookingTest < ActiveSupport::TestCase
  test "can create booking" do
    booking = create :booking
    assert booking.persisted?
    assert booking.listing.persisted?
    assert booking.start_date.present?
    assert booking.end_date.present?
  end

  test "fails to create booking without listing" do
    booking = build :booking, listing: nil
    assert booking.invalid?
    assert booking.errors.all? { |e| e.attribute == :listing && e.type == :blank }
  end

  test "fails to create booking without start_date" do
    booking = build :booking, start_date: nil
    assert booking.invalid?
    assert booking.errors.any? { |e| e.attribute == :start_date && e.type == :blank }
  end

  test "fails to create booking without end_date" do
    booking = build :booking, end_date: nil
    assert booking.invalid?
    assert booking.errors.any? { |e| e.attribute == :end_date && e.type == :blank }
  end

  test "fails to create booking with end_date before start_date" do
    booking = build :booking, start_date: Date.today, end_date: Date.today - 1.day
    assert booking.invalid?
    assert booking.errors.all? { |e| e.attribute == :start_date && e.type == :before }
  end

  test "fails to create booking before today" do
    booking = build :booking, start_date: Date.today - 1.week, end_date: Date.today + 1.day
    assert booking.invalid?
    assert booking.errors.all? { |e| e.attribute == :start_date && e.type == :on_or_after }
  end

  test "booking has missions" do
    booking = create :booking
    assert booking.missions.any?
  end

  test "booking default state is active" do
    booking = create :booking
    assert booking.active?
  end

  test "booking can be canceled" do
    booking = create :booking
    booking.cancel!
    assert booking.canceled?
  end

  test "canceling a booking cancels missions" do
    booking = create :booking
    booking.cancel!
    assert booking.missions.all?(&:canceled?)
  end

  test "creating a booking creates a first_checkin mission" do
    booking = create :booking
    assert_equal booking.missions.first_checkin.count, 1
    assert booking.missions.first_checkin.first.date == booking.start_date
  end

  test "creating a booking creates a last_checkout mission" do
    booking = create :booking
    assert_equal booking.missions.last_checkout.count, 1
    assert booking.missions.last_checkout.first.date == booking.end_date
  end
end
