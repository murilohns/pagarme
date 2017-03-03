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

ActiveRecord::Schema.define(version: 20170303193609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transactions", force: :cascade do |t|
    t.string   "card_number",           limit: 19
    t.string   "card_holder_name",      limit: 60
    t.string   "card_expiration_month", limit: 2
    t.string   "card_expiration_year",  limit: 4
    t.string   "card_cvv",              limit: 3
    t.string   "card_hash"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

end
