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

ActiveRecord::Schema[7.0].define(version: 2024_06_20_073308) do
  create_table "active_storage_attachments", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8", force: :cascade do |t|
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

  create_table "active_storage_variant_records", charset: "utf8", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "communities", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "password_digest", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "community_memberships", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "community_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_community_memberships_on_community_id"
    t.index ["user_id"], name: "index_community_memberships_on_user_id"
  end

  create_table "evaluation_items", charset: "utf8", force: :cascade do |t|
    t.bigint "community_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_evaluation_items_on_community_id"
  end

  create_table "messages", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "community_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_messages_on_community_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "peer_evaluations", charset: "utf8", force: :cascade do |t|
    t.bigint "evaluation_item_id", null: false
    t.bigint "evaluator_id", null: false
    t.bigint "evaluatee_id", null: false
    t.integer "score", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluatee_id"], name: "index_peer_evaluations_on_evaluatee_id"
    t.index ["evaluation_item_id"], name: "index_peer_evaluations_on_evaluation_item_id"
    t.index ["evaluator_id"], name: "index_peer_evaluations_on_evaluator_id"
  end

  create_table "self_evaluations", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "evaluation_item_id", null: false
    t.integer "score", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_item_id"], name: "index_self_evaluations_on_evaluation_item_id"
    t.index ["user_id"], name: "index_self_evaluations_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", null: false
    t.text "profile"
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
  add_foreign_key "community_memberships", "communities"
  add_foreign_key "community_memberships", "users"
  add_foreign_key "evaluation_items", "communities"
  add_foreign_key "messages", "communities"
  add_foreign_key "messages", "users"
  add_foreign_key "peer_evaluations", "evaluation_items"
  add_foreign_key "peer_evaluations", "users", column: "evaluatee_id"
  add_foreign_key "peer_evaluations", "users", column: "evaluator_id"
  add_foreign_key "self_evaluations", "evaluation_items"
  add_foreign_key "self_evaluations", "users"
end
