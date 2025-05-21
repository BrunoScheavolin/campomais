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

ActiveRecord::Schema[7.2].define(version: 2025_05_14_191448) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "animal_productions", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.string "breed"
    t.string "purpose"
    t.integer "animal_quantity"
    t.string "average_weight"
    t.integer "eggs_produced"
    t.decimal "milk_production", precision: 10, scale: 2
    t.text "notes"
    t.decimal "used_area", precision: 10, scale: 2
    t.decimal "revenue", precision: 14, scale: 2, default: "0.0"
    t.decimal "expenses", precision: 14, scale: 2, default: "0.0"
    t.bigint "production_module_id", null: false
    t.bigint "admin_id", null: false
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_animal_productions_on_admin_id"
    t.index ["production_module_id"], name: "index_animal_productions_on_production_module_id"
    t.index ["property_id"], name: "index_animal_productions_on_property_id"
  end

  create_table "production_modules", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.json "settings"
    t.integer "module_type"
    t.json "production_settings"
    t.bigint "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_production_modules_on_admin_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "size"
    t.bigint "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_properties_on_admin_id"
  end

  create_table "property_accesses", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_property_accesses_on_property_id"
    t.index ["user_id"], name: "index_property_accesses_on_user_id"
  end

  create_table "supplies", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.decimal "expense"
    t.bigint "animal_production_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_production_id"], name: "index_supplies_on_animal_production_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.text "description"
    t.date "due_date"
    t.boolean "priority"
    t.boolean "uses_supplies"
    t.decimal "expense"
    t.text "observation"
    t.string "task_type"
    t.string "responsible"
    t.integer "supply_id"
    t.integer "supply_quantity"
    t.bigint "animal_production_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_production_id"], name: "index_tasks_on_animal_production_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "animal_productions", "admins"
  add_foreign_key "animal_productions", "production_modules"
  add_foreign_key "animal_productions", "properties"
  add_foreign_key "production_modules", "admins"
  add_foreign_key "properties", "admins"
  add_foreign_key "property_accesses", "properties"
  add_foreign_key "property_accesses", "users"
  add_foreign_key "supplies", "animal_productions"
  add_foreign_key "tasks", "animal_productions"
end
