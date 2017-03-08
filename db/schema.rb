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

ActiveRecord::Schema.define(version: 20170307201613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "information", force: :cascade do |t|
    t.string   "street"
    t.string   "neighborhood"
    t.string   "zipcode"
    t.string   "street_number"
    t.string   "complementary"
    t.string   "ddd"
    t.string   "phone_number"
    t.integer  "member_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["member_id"], name: "index_information_on_member_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.index ["email"], name: "index_members_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true, using: :btree
  end

  create_table "recipients", force: :cascade do |t|
    t.string   "bank_code",        limit: 3
    t.string   "agencia",          limit: 4
    t.string   "agencia_dv",       limit: 1
    t.string   "conta",            limit: 10
    t.string   "conta_dv",         limit: 1
    t.string   "legal_name",       limit: 60
    t.string   "document_number",  limit: 14
    t.text     "code"
    t.boolean  "transfer_enabled"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "amount"
    t.string   "pay_method"
    t.integer  "member_id"
    t.text     "boleto_url"
    t.text     "boleto_barcode"
    t.text     "card_hash"
    t.string   "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["member_id"], name: "index_transactions_on_member_id", using: :btree
  end

  add_foreign_key "information", "members"
  add_foreign_key "transactions", "members"
end
