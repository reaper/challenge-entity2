require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservation = create(:reservation)
  end

  test "should get index" do
    get listing_reservations_url(@reservation.listing)
    assert_response :success
  end

  test "should get new" do
    get new_listing_reservation_url(@reservation.listing)
    assert_response :success
  end

  test "should create reservation" do
    assert_difference("Reservation.count") do
      post listing_reservations_url(@reservation.listing), params: { reservation: { start_date: Date.today, end_date: Date.today + 1.day } }
    end

    assert_redirected_to listing_url(@reservation.listing)
  end

  test "should show reservation" do
    get listing_reservation_url(@reservation.listing, @reservation)
    assert_response :success
  end

  test "should get edit" do
    get edit_listing_reservation_url(@reservation.listing, @reservation)
    assert_response :success
  end

  test "should update reservation" do
    patch listing_reservation_url(@reservation.listing, @reservation), params: { reservation: { end_date: 1.week.from_now } }
    assert_redirected_to listing_url(@reservation.listing)
  end

  test "should destroy reservation" do
    assert_difference("Reservation.count", -1) do
      delete listing_reservation_url(@reservation.listing, @reservation)
    end

    assert_redirected_to listing_url(@reservation.listing)
  end

  ## JSON

  test "should get index with json" do
    get listing_reservations_url(@reservation.listing), as: :json
    assert_response :success
    assert response.parsed_body.is_a?(Array)
    assert response.parsed_body.first.is_a?(Hash)
    assert response.parsed_body.first["id"].present?
    assert response.parsed_body.first["start_date"].present?
    assert response.parsed_body.first["end_date"].present?
  end

  test "should create reservation with json" do
    assert_difference("Reservation.count") do
      post listing_reservations_url(@reservation.listing),
      params: {
        reservation: {
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

  test "should show reservation with json" do
    get listing_reservation_url(@reservation.listing, @reservation), as: :json
    assert_response :success
    assert response.parsed_body.is_a?(Hash)
    assert response.parsed_body["id"].present?
    assert response.parsed_body["start_date"].present?
    assert response.parsed_body["end_date"].present?
  end

  test "should update reservation with json" do
    patch listing_reservation_url(@reservation.listing, @reservation),
      params: {
        reservation: {
          end_date: 1.week.from_now
        }
      }, as: :json
    assert response.parsed_body.is_a?(Hash)
    assert response.parsed_body["id"].present?
    assert response.parsed_body["start_date"].present?
    assert response.parsed_body["end_date"].present?
  end

  test "should destroy reservation with json" do
    assert_difference("Reservation.count", -1) do
      delete listing_reservation_url(@reservation.listing, @reservation), as: :json
    end
  end
end
