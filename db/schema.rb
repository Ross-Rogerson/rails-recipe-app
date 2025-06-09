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

ActiveRecord::Schema[8.0].define(version: 2025_06_05_070822) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "following_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id", "following_id"], name: "index_follows_on_follower_id_and_following_id", unique: true
    t.index ["follower_id"], name: "index_follows_on_follower_id"
    t.index ["following_id"], name: "index_follows_on_following_id"
  end

  create_table "grocery_items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "quantity", null: false
    t.integer "quantity_unit", null: false
    t.decimal "price", precision: 5, scale: 2, null: false
    t.decimal "unit_price", precision: 5, scale: 2
    t.integer "supermarket", null: false
    t.boolean "has_plastic_packaging", null: false
    t.bigint "user_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_grocery_items_on_ingredient_id"
    t.index ["name", "supermarket", "quantity", "quantity_unit"], name: "index_grocery_items_on_unique_combination", unique: true
    t.index ["user_id"], name: "index_grocery_items_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "calories_per_100g", precision: 8, scale: 2, null: false
    t.decimal "saturated_fat_per_100g", precision: 8, scale: 2, null: false
    t.decimal "unsaturated_fat_per_100g", precision: 8, scale: 2, null: false
    t.decimal "carbohydrates_per_100g", precision: 8, scale: 2, null: false
    t.decimal "sugars_per_100g", precision: 8, scale: 2, null: false
    t.decimal "fibre_per_100g", precision: 8, scale: 2, null: false
    t.decimal "protein_per_100g", precision: 8, scale: 2, null: false
    t.decimal "salt_per_100g", precision: 8, scale: 2, null: false
    t.boolean "vegetarian", null: false
    t.integer "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["name"], name: "index_ingredients_on_name", unique: true
    t.index ["user_id"], name: "index_ingredients_on_user_id"
  end

  create_table "meal_ingredients", force: :cascade do |t|
    t.bigint "meal_id", null: false
    t.bigint "ingredient_id", null: false
    t.integer "quantity", null: false
    t.integer "quantity_unit", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_meal_ingredients_on_ingredient_id"
    t.index ["meal_id", "ingredient_id"], name: "index_meal_ingredients_on_meal_id_and_ingredient_id", unique: true
    t.index ["meal_id"], name: "index_meal_ingredients_on_meal_id"
  end

  create_table "meals", force: :cascade do |t|
    t.string "name", null: false
    t.integer "portions", null: false
    t.decimal "calories_per_portion", precision: 8, scale: 2, null: false
    t.decimal "saturated_fat_per_portion", precision: 8, scale: 2, null: false
    t.decimal "unsaturated_fat_per_portion", precision: 8, scale: 2, null: false
    t.decimal "carbohydrates_per_portion", precision: 8, scale: 2, null: false
    t.decimal "sugars_per_portion", precision: 8, scale: 2, null: false
    t.decimal "fibre_per_portion", precision: 8, scale: 2, null: false
    t.decimal "protein_per_portion", precision: 8, scale: 2, null: false
    t.decimal "salt_per_portion", precision: 8, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_meals_on_user_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "follows", "users", column: "following_id"
  add_foreign_key "grocery_items", "ingredients"
  add_foreign_key "grocery_items", "users"
  add_foreign_key "ingredients", "users"
  add_foreign_key "meal_ingredients", "ingredients"
  add_foreign_key "meal_ingredients", "meals"
  add_foreign_key "meals", "users"
end
