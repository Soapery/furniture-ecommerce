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

ActiveRecord::Schema[7.0].define(version: 2023_12_01_224537) do
  create_table "order_products", force: :cascade do |t|
    t.integer "amount"
    t.decimal "base_cost"
    t.decimal "gst"
    t.decimal "pst"
    t.decimal "hst"
    t.decimal "total_cost"
    t.integer "orders_id", null: false
    t.integer "products_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orders_id"], name: "index_order_products_on_orders_id"
    t.index ["products_id"], name: "index_order_products_on_products_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "base_cost"
    t.decimal "total_cost"
    t.string "order_status", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "variation", limit: 50
    t.string "pattern", limit: 50
    t.boolean "outdoor"
    t.decimal "price"
    t.decimal "on_sale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name", limit: 50
    t.decimal "gst"
    t.decimal "pst"
    t.decimal "hst"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", limit: 50
    t.string "username", limit: 50
    t.date "birthday"
    t.string "address", limit: 250
    t.string "postal_code", limit: 7
    t.boolean "is_admin"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "order_products", "orders", column: "orders_id"
  add_foreign_key "order_products", "products", column: "products_id"
end
