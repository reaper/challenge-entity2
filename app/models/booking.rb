class Booking < ApplicationRecord
  belongs_to :listing
  has_many :missions, as: :missionable, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_date :start_date, before: :end_date, on_or_after: lambda { Date.current }
  validate :check_overlapping, if: -> { self.start_date_changed? || self.end_date_changed? }

  scope :overlaps, -> (booking) do
    where.not(id: booking.id)
      .where("((start_date <= ?) and (end_date >= ?))", booking.end_date, booking.start_date)
  end

  state_machine :state, initial: :active do
    event :cancel do
      transition [:active] => :canceled
    end

    after_transition to: :canceled do |booking|
      booking.missions.each do |mission|
        mission.cancel! unless mission.canceled?
      end
    end
  end

  after_save :create_first_checkin_missions, if: -> { self.saved_change_to_start_date? }
  after_save :create_last_checkout_missions, if: -> { self.saved_change_to_end_date? }

  private
    def check_overlapping
      if Booking.overlaps(self).any?
        errors.add(:start_date, "overlaps existing booking")
      end
    end

    def create_first_checkin_missions
      # cancel existing missions
      self.missions
        .with_state(:active)
        .first_checkin
        .each(&:cancel!)

      self.missions.create!(
        mission_type: :first_checkin,
        date: self.start_date,
      )
    end

    def create_last_checkout_missions
      # cancel existing missions
      self.missions
        .with_state(:active)
        .last_checkout
        .each(&:cancel!)

      # create last_checkout mission
      self.missions.create!(
        mission_type: :last_checkout,
        date: self.end_date,
      )

      # cancel existing checkout_checkin missions
      self
        .listing
        .missions
        .with_state(:active)
        .checkout_checkin
        .where(date: self.end_date)
        .each(&:cancel!)
    end
end
