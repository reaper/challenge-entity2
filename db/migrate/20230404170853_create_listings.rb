class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.integer :num_rooms, null: false, default: 1

      t.timestamps
    end
  end
end
