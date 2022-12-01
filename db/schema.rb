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

ActiveRecord::Schema[7.0].define(version: 2022_11_28_063940) do
  create_table "accounts", force: :cascade do |t|
    t.integer "connection_id", null: false
    t.string "saltedge_id", null: false
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connection_id"], name: "index_accounts_on_connection_id"
    t.index ["saltedge_id"], name: "index_accounts_on_saltedge_id", unique: true
  end

  create_table "connections", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "saltedge_id", null: false
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_connections_on_customer_id"
    t.index ["saltedge_id"], name: "index_connections_on_saltedge_id", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "saltedge_id", null: false
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["saltedge_id"], name: "index_customers_on_saltedge_id", unique: true
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "code", null: false
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_providers_on_code", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "saltedge_id", null: false
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["saltedge_id"], name: "index_transactions_on_saltedge_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "connections"
  add_foreign_key "connections", "customers"
  add_foreign_key "customers", "users"
  add_foreign_key "transactions", "accounts"
end
