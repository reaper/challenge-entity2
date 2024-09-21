class CreateMissions < ActiveRecord::Migration[7.0]
  def change
    create_table :missions do |t|
      t.references :missionable, polymorphic: true, null: false
      t.references :listing, null: false, foreign_key: true
      t.integer :mission_type, null: false
      t.date :date, null: false
      t.monetize :price, null: false
      t.string :state, null: false

      t.timestamps
    end
  end
end
