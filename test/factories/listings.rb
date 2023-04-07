FactoryBot.define do
  factory :listing do
    num_rooms { 2 }

    after(:build) do |listing|
      listing.bookings << FactoryBot.build(:booking, listing: listing)
    end
  end
end
