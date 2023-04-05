require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  test "can create reservation" do
    reservation = create :reservation
    assert reservation.persisted?
    assert reservation.listing.persisted?
    assert reservation.start_date.present?
    assert reservation.end_date.present?
  end

  test "fails to create reservation without listing" do
    reservation = build :reservation, listing: nil
    assert reservation.invalid?
    assert reservation.errors.all? { |e| e.attribute == :listing && e.type == :blank }
  end

  test "fails to create reservation without start_date" do
    reservation = build :reservation, start_date: nil
    assert reservation.invalid?
    assert reservation.errors.any? { |e| e.attribute == :start_date && e.type == :blank }
  end

  test "fails to create reservation without end_date" do
    reservation = build :reservation, end_date: nil
    assert reservation.invalid?
    assert reservation.errors.any? { |e| e.attribute == :end_date && e.type == :blank }
  end

  test "fails to create reservation with end_date before start_date" do
    reservation = build :reservation, start_date: Date.today, end_date: Date.today - 1.day
    assert reservation.invalid?
    assert reservation.errors.all? { |e| e.attribute == :start_date && e.type == :before }
  end

  test "fails to create reservation with start_date before today" do
    reservation = build :reservation, start_date: 1.day.ago, end_date: Date.today + 1.day
    assert reservation.invalid?
    assert reservation.errors.all? { |e| e.attribute == :start_date && e.type == :on_or_after }
  end

  test "reservation has missions" do
    reservation = create :reservation
    assert reservation.missions.any?
  end

  test "reservation default state is active" do
    reservation = create :reservation
    assert reservation.active?
  end

  test "reservation can be canceled" do
    reservation = create :reservation
    reservation.cancel!
    assert reservation.canceled?
  end

  test "canceling a reservation cancels missions" do
    reservation = create :reservation
    reservation.cancel!
    assert reservation.missions.all?(&:canceled?)
  end

  test "creating a reservation creates a checkout_checkin mission" do
    reservation = create :reservation
    assert_equal reservation.missions.checkout_checkin.count, 1
    assert reservation.missions.checkout_checkin.first.date == reservation.end_date
  end

  test "fails to create checkout_checkin mission if already existing last_checkout" do
    start_date = Date.today
    end_date = Date.today + 3.day

    booking = create :booking, start_date: start_date, end_date: end_date
    reservation = create :reservation, listing: booking.listing, start_date: start_date + 1.day, end_date: end_date

    assert_equal booking.missions.map(&:mission_type), %w(first_checkin last_checkout)
    assert reservation.missions.empty?
  end
end
