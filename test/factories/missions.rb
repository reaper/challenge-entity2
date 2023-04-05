FactoryBot.define do
  factory :mission do
    first_checkin
    date { 3.days.from_now }

    trait :first_checkin do
      association :missionable, factory: :booking
      mission_type { :first_checkin }
    end

    trait :last_checkout do
      association :missionable, factory: :booking
      mission_type { :last_checkout }
    end

    trait :checkout_checkin do
      association :missionable, factory: :reservation
      mission_type { :checkout_checkin }
    end
  end
end
