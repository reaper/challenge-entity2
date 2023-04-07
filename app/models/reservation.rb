class Reservation < ApplicationRecord
  belongs_to :listing
  has_many :missions, as: :missionable, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_date :start_date, before: :end_date, on_or_after: lambda { Date.current }
  validate :booking_available, if: -> { self.listing.present? }

  state_machine :state, initial: :active do
    event :cancel do
      transition [:active] => :canceled
    end

    after_transition to: :canceled do |reservation|
      reservation.missions.each do |mission|
        mission.cancel! unless mission.canceled?
      end
    end
  end

  after_save :create_checkout_checkin_missions, if: -> { self.saved_change_to_end_date? }

  private
    def booking_available
      unless self.listing.bookings.where("start_date <= ? AND end_date >= ?", self.start_date, self.end_date).exists?
        self.errors.add(:start_date, "is not available. No booking found for this date range.")
        self.errors.add(:end_date, "is not available. No booking found for this date range.")
      end
    end

    def create_checkout_checkin_missions
      if self.can_create_checkout_checkin_mission?
        self.missions.create!(
          mission_type: :checkout_checkin,
          date: self.end_date,
        )
      else
        # cancel existing missions
        self
          .missions
          .with_state(:active)
          .checkout_checkin
          .each(&:cancel!)
      end
    end

    def can_create_checkout_checkin_mission?
      self
        .listing
        .missions
        .with_state(:active)
        .last_checkout
        .where(date: self.end_date)
        .none?
    end
end
