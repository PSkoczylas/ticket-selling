# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_13_154836) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "start_date"
    t.time "start_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ticket_purchases", force: :cascade do |t|
    t.string "email"
    t.string "token"
    t.integer "amount"
    t.bigint "ticket_id", null: false
    t.index ["ticket_id"], name: "index_ticket_purchases_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.text "info"
    t.decimal "price", precision: 8, scale: 2
    t.string "currency", default: "EUR"
    t.integer "available_quantity"
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

  add_foreign_key "ticket_purchases", "tickets"
  add_foreign_key "tickets", "events"
end
