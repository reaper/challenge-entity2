FactoryBot.define do
  factory :reservation do
    association :listing, :with_bookings
    start_date { 5.days.from_now }
    end_date { 1.week.from_now }
  end
end
