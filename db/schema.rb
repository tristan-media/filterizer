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

ActiveRecord::Schema.define(version: 20140525215434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "title"
    t.integer  "venue_id"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "opening_date"
    t.time     "opening_start_time"
    t.time     "opening_end_time"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "tweeted",            default: false, null: false
  end

  add_index "events", ["end_date"], name: "index_events_on_end_date", using: :btree
  add_index "events", ["opening_date"], name: "index_events_on_opening_date", using: :btree
  add_index "events", ["start_date"], name: "index_events_on_start_date", using: :btree
  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

  create_table "neighborhoods", force: true do |t|
    t.string "name"
  end

  add_index "neighborhoods", ["name"], name: "index_neighborhoods_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "neighborhood_id"
    t.string   "twitter"
  end

  add_index "venues", ["neighborhood_id"], name: "index_venues_on_neighborhood_id", using: :btree

end
