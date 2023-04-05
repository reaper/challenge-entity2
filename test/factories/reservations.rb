FactoryBot.define do
  factory :reservation do
    association :listing
    start_date { 3.days.from_now }
    end_date { 4.days.from_now }
  end
end
