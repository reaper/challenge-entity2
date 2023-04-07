class Mission < ApplicationRecord
  monetize :price_cents

  PRICE_FOR_MISSION = {
    eur: {
      first_checkin: 10,
      last_checkout: 5,
      checkout_checkin: 10
    }
  }

  enum :mission_type, [ :first_checkin, :last_checkout, :checkout_checkin ]

  belongs_to :missionable, polymorphic: true
  belongs_to :listing

  default_scope { order(listing_id: :asc, date: :desc) }

  before_validation :set_defaults
  before_validation :set_price

  state_machine :state, initial: :active do
    event :cancel do
      transition [:active] => :canceled
    end
  end

  private
    def set_defaults
      self.listing = self.missionable.listing
    end

    def set_price
      self.price = PRICE_FOR_MISSION.dig(:eur, self.mission_type.to_sym) * self.listing.num_rooms
    end
end
