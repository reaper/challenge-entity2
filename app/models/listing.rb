class Listing < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :missions, dependent: :destroy

  before_create do
    self.title = Faker::Fantasy::Tolkien.location unless self.title.present?
    self.address = Faker::Address.full_address unless self.address.present?
    self.description = Faker::Lorem.paragraph unless self.description.present?
  end
end
