# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_05_192021) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "listing_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_bookings_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.integer "num_rooms", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.string "address"
  end

  create_table "missions", force: :cascade do |t|
    t.string "missionable_type", null: false
    t.bigint "missionable_id", null: false
    t.bigint "listing_id", null: false
    t.integer "mission_type", null: false
    t.date "date", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "EUR", null: false
    t.string "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_missions_on_listing_id"
    t.index ["missionable_type", "missionable_id"], name: "index_missions_on_missionable"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "listing_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_reservations_on_listing_id"
  end

  add_foreign_key "bookings", "listings"
  add_foreign_key "missions", "listings"
  add_foreign_key "reservations", "listings"
end
