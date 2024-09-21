FactoryBot.define do
  factory :booking do
    association :listing
    start_date { 2.days.from_now }
    end_date { 3.weeks.from_now }
  end
end
