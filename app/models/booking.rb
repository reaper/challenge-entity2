class Booking < ApplicationRecord
  belongs_to :listing
  has_many :missions, as: :missionable

  state_machine :state, initial: :active do
    event :cancel do
      transition [:active] => :canceled
    end
  end

  after_save :create_first_checkin_missions, if: -> { self.saved_change_to_start_date? }
  after_save :create_last_checkout_missions, if: -> { self.saved_change_to_end_date? }

  private
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

      # create last_checkout mission mission
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
