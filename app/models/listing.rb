class Listing < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :missions, dependent: :destroy

  before_create do
    self.title = Faker::Fantasy::Tolkien.location
    self.address = Faker::Address.full_address
    self.description = Faker::Lorem.paragraph
  end
end
