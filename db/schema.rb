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

ActiveRecord::Schema.define(version: 20140518201342) do

  create_table "addresses", id: false, force: true do |t|
    t.integer  "id"
    t.string   "address_type"
    t.boolean  "mailing_address"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "country"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.boolean  "active"
    t.boolean  "family_address"
    t.string   "company"
    t.boolean  "statement_address"
    t.integer  "address_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["id"], name: "addresses_id_index", unique: true

  create_table "addresses_individuals", force: true do |t|
    t.integer  "address_id"
    t.integer  "individual_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses_individuals", ["address_id"], name: "index_addresses_individuals_on_address_id"
  add_index "addresses_individuals", ["individual_id"], name: "index_addresses_individuals_on_individual_id"

  create_table "individuals", id: false, force: true do |t|
    t.integer  "id"
    t.integer  "family_id"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "goes_by_name"
    t.string   "title"
    t.string   "picture_url"
    t.string   "family_position"
    t.string   "suffix"
    t.string   "full_name"
    t.string   "friendly_name"
    t.string   "family_picture_url"
    t.datetime "date_of_birth"
    t.string   "member_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "individuals", ["id"], name: "id_index", unique: true

  create_table "phone_numbers", id: false, force: true do |t|
    t.integer  "id"
    t.string   "phone_type"
    t.integer  "phone_type_id"
    t.integer  "phone_ref"
    t.boolean  "listed"
    t.string   "phone_number"
    t.boolean  "preferred"
    t.boolean  "family_phone"
    t.boolean  "address_phone"
    t.string   "extension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phone_numbers", ["id"], name: "phone_numbers_id_index", unique: true

end
