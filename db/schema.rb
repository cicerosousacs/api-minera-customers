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

ActiveRecord::Schema[7.0].define(version: 2024_03_24_144238) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies_by_customers", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "quantity_company"
    t.integer "quantity_company_references"
    t.integer "quantity_company_remaining"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.bigint "customer_id", null: false
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_users_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "gender"
    t.string "cpf"
    t.string "cnpj"
    t.string "phone"
    t.string "cellphone"
    t.date "birth_date"
    t.string "cep"
    t.string "street"
    t.integer "number"
    t.string "complement"
    t.string "reference"
    t.string "district"
    t.string "city"
    t.string "state"
    t.boolean "authenticated_email"
    t.bigint "status_id", null: false
    t.bigint "subscription_id", null: false
    t.integer "quantity_profiles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_customers_on_status_id"
    t.index ["subscription_id"], name: "index_customers_on_subscription_id"
  end

  create_table "histories", force: :cascade do |t|
    t.string "type_history"
    t.datetime "date_history"
    t.string "name_list"
    t.string "observation"
    t.jsonb "filters"
    t.integer "customer_user_id"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "key"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "description"
    t.bigint "type_subscription_id", null: false
    t.integer "quantity_users"
    t.integer "quantity_companies"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type_subscription_id"], name: "index_subscriptions_on_type_subscription_id"
  end

  create_table "type_subscriptions", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "customer_users", "customers"
  add_foreign_key "customers", "statuses"
  add_foreign_key "customers", "subscriptions"
  add_foreign_key "subscriptions", "type_subscriptions"
end
