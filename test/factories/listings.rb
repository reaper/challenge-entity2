FactoryBot.define do
  factory :listing do
    num_rooms { rand(1..10) }
  end
end
