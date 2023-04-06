require "test_helper"

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking = create(:booking)
  end

  test "should get index" do
    get listing_bookings_url(@booking.listing)
    assert_response :success
  end

  test "should get new" do
    get new_listing_booking_url(@booking.listing)
    assert_response :success
  end

  test "should create booking" do
    assert_difference("Booking.count") do
      post listing_bookings_url(@booking.listing), params: { booking: { start_date: Date.today, end_date: Date.today + 1.day } }
    end

    assert_redirected_to listing_url(@booking.listing)
  end

  test "should show booking" do
    get listing_booking_url(@booking.listing, @booking)
    assert_response :success
  end

  test "should get edit" do
    get edit_listing_booking_url(@booking.listing, @booking)
    assert_response :success
  end

  test "should update booking" do
    patch listing_booking_url(@booking.listing, @booking), params: { booking: { end_date: 1.week.from_now } }
    assert_redirected_to listing_url(@booking.listing)
  end

  test "should destroy booking" do
    assert_difference("Booking.count", -1) do
      delete listing_booking_url(@booking.listing, @booking)
    end

    assert_redirected_to listing_url(@booking.listing)
  end
end
