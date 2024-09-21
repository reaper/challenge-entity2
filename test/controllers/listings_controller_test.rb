require "test_helper"

class ListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @listing = create(:listing)
  end

  test "should get index" do
    get listings_url
    assert_response :success
  end

  test "should get new" do
    get new_listing_url
    assert_response :success
  end

  test "should create listing" do
    assert_difference("Listing.count") do
      post listings_url, params: { listing: { num_rooms: 3 } }
    end

    assert_redirected_to listing_url(Listing.last)
  end

  test "should show listing" do
    get listing_url(@listing)
    assert_response :success
  end

  test "should get edit" do
    get edit_listing_url(@listing)
    assert_response :success
  end

  test "should update listing" do
    patch listing_url(@listing), params: { listing: { num_rooms: 5 } }
    assert_redirected_to listing_url(@listing)
  end

  test "should destroy listing" do
    assert_difference("Listing.count", -1) do
      delete listing_url(@listing)
    end

    assert_redirected_to listings_url
  end

  ## JSON

  test "should get index with json" do
    get listings_url, as: :json
    assert_response :success
    assert response.parsed_body.is_a?(Array)
    assert response.parsed_body.first.is_a?(Hash)
    assert response.parsed_body.first["id"].present?
    assert response.parsed_body.first["num_rooms"].present?
  end

  test "should create listing with json" do
    assert_difference("Listing.count") do
      post listings_url,
      params: {
        listing: {
          num_rooms: 2
        }
      }, as: :json

      assert response.parsed_body.is_a?(Hash)
      assert response.parsed_body["id"].present?
      assert response.parsed_body["num_rooms"].present?
    end
  end

  test "should show listing with json" do
    get listing_url(@listing), as: :json
    assert_response :success
    assert response.parsed_body.is_a?(Hash)
    assert response.parsed_body["id"].present?
    assert response.parsed_body["num_rooms"].present?
  end

  test "should update listing with json" do
    patch listing_url(@listing),
      params: {
        listing: {
          num_rooms: 3
        }
      }, as: :json
    assert response.parsed_body.is_a?(Hash)
    assert response.parsed_body["id"].present?
    assert response.parsed_body["num_rooms"].present?
  end

  test "should destroy listing with json" do
    assert_difference("Listing.count", -1) do
      delete listing_url(@listing), as: :json
    end
  end
end
