# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Booking.delete_all
Reservation.delete_all
Mission.delete_all
Listing.delete_all

{
  "listings": [
    { "id": 1, "num_rooms": 2 },
    { "id": 2, "num_rooms": 1 },
    { "id": 3, "num_rooms": 3 }
  ],
  "bookings": [
    { "id": 1, "listing_id": 1, "start_date": "2016-10-10", "end_date": "2016-10-15" },
    { "id": 2, "listing_id": 1, "start_date": "2016-10-16", "end_date": "2016-10-20" },
    { "id": 3, "listing_id": 2, "start_date": "2016-10-15", "end_date": "2016-10-20" }
  ],
  "reservations": [
    { "id": 1, "listing_id": 1, "start_date": "2016-10-11", "end_date": "2016-10-13" },
    { "id": 2, "listing_id": 1, "start_date": "2016-10-13", "end_date": "2016-10-15" },
    { "id": 3, "listing_id": 1, "start_date": "2016-10-16", "end_date": "2016-10-20" },
    { "id": 4, "listing_id": 2, "start_date": "2016-10-15", "end_date": "2016-10-18" }
  ]
}.each do |key, value|
  value.each do |attributes|
    object = key.to_s.classify.constantize.create!(attributes)
    puts "#{object.class} created: #{object.inspect}"
  end
end
