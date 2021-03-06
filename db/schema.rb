# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161021034437) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acts_as_bookable_bookings", force: :cascade do |t|
    t.integer  "bookable_id"
    t.string   "bookable_type"
    t.integer  "booker_id"
    t.string   "booker_type"
    t.integer  "amount"
    t.text     "schedule"
    t.datetime "time_start"
    t.datetime "time_end"
    t.datetime "time"
    t.integer  "total_sum"
    t.datetime "created_at"
  end

  add_index "acts_as_bookable_bookings", ["bookable_type", "bookable_id"], name: "index_acts_as_bookable_bookings_bookable", using: :btree
  add_index "acts_as_bookable_bookings", ["booker_type", "booker_id"], name: "index_acts_as_bookable_bookings_booker", using: :btree

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "provider"
    t.string   "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.string   "schedule"
    t.integer  "capacity"
    t.string   "location"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.json     "avatars"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "acts_as_bookable_booking_id"
    t.string   "braintree_payment_id"
    t.string   "status"
    t.string   "fourdigit"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "payments", ["acts_as_bookable_booking_id"], name: "index_payments_on_acts_as_bookable_booking_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taggings", ["listing_id"], name: "index_taggings_on_listing_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "name"
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.json     "avatars"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "taggings", "listings"
  add_foreign_key "taggings", "tags"
end
