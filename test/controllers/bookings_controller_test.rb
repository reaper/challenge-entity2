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

  ## JSON

  test "should get index with json" do
    get listing_bookings_url(@booking.listing), as: :json
    assert_response :success
    assert response.parsed_body.is_a?(Array)
    assert response.parsed_body.first.is_a?(Hash)
    assert response.parsed_body.first["id"].present?
    assert response.parsed_body.first["start_date"].present?
    assert response.parsed_body.first["end_date"].present?
  end

  test "should create booking with json" do
    assert_difference("Booking.count") do
      post listing_bookings_url(@booking.listing),
      params: {
        booking: {
          start_date: Date.today,
          end_date: Date.today + 1.day
        }
      }, as: :json

      assert response.parsed_body.is_a?(Hash)
      assert response.parsed_body["id"].present?
      assert response.parsed_body["start_date"].present?
      assert response.parsed_body["end_date"].present?
    end
  end

  test "should show booking with json" do
    get listing_booking_url(@booking.listing, @booking), as: :json
    assert_response :success
    assert response.parsed_body.is_a?(Hash)
    assert response.parsed_body["id"].present?
    assert response.parsed_body["start_date"].present?
    assert response.parsed_body["end_date"].present?
  end

  test "should update booking with json" do
    patch listing_booking_url(@booking.listing, @booking),
      params: {
        booking: {
          end_date: 1.week.from_now
        }
      }, as: :json
    assert response.parsed_body.is_a?(Hash)
    assert response.parsed_body["id"].present?
    assert response.parsed_body["start_date"].present?
    assert response.parsed_body["end_date"].present?
  end

  test "should destroy booking with json" do
    assert_difference("Booking.count", -1) do
      delete listing_booking_url(@booking.listing, @booking), as: :json
    end
  end
end
