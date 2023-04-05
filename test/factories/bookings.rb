FactoryBot.define do
  factory :booking do
    association :listing
    start_date { 2.days.from_now }
    end_date { 10.days.from_now }
  end
end
