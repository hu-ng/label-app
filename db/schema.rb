# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_11_184516) do

  create_table "addresses", force: :cascade do |t|
    t.string "unique_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "parcels", force: :cascade do |t|
    t.string "unique_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_parcels_on_user_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.string "unique_id"
    t.integer "user_id"
    t.integer "to_address_id"
    t.integer "from_address_id"
    t.integer "parcel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_address_id"], name: "index_shipments_on_from_address_id"
    t.index ["parcel_id"], name: "index_shipments_on_parcel_id"
    t.index ["to_address_id"], name: "index_shipments_on_to_address_id"
    t.index ["user_id"], name: "index_shipments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
