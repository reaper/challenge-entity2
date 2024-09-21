FactoryBot.define do
  factory :listing do
    num_rooms { 2 }

    trait :with_bookings do
      after(:build) do |listing|
        listing.bookings << FactoryBot.build(:booking, listing: listing)
      end
    end
  end
end
