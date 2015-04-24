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

ActiveRecord::Schema.define(version: 20150416080115) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoices", force: :cascade do |t|
    t.string   "floor_id"
    t.string   "name"
    t.integer  "floor_area"
    t.integer  "deposit"
    t.integer  "rent"
    t.integer  "management_fee"
    t.integer  "tax_1"
    t.integer  "subtotal_1"
    t.integer  "electric_fee"
    t.integer  "tax_2"
    t.integer  "subtotal_2"
    t.integer  "water_fee"
    t.integer  "tv_fee"
    t.integer  "total"
    t.string   "account_location"
    t.string   "account_number"
    t.string   "account_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
