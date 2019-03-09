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

ActiveRecord::Schema.define(version: 2019_03_09_124600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "card_id"
    t.index ["card_id"], name: "index_attempts_on_card_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.text "question"
    t.string "correct_answer"
    t.string "wrong_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "deck_id"
    t.bigint "resource_id"
    t.index ["deck_id"], name: "index_cards_on_deck_id"
    t.index ["resource_id"], name: "index_cards_on_resource_id"
  end

  create_table "curriculums", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_curriculums_on_user_id"
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "curriculum_id"
    t.index ["curriculum_id"], name: "index_decks_on_curriculum_id"
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feed_events", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.bigint "deck_id"
    t.bigint "event_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "about_user_id"
    t.index ["deck_id"], name: "index_feed_events_on_deck_id"
    t.index ["event_type_id"], name: "index_feed_events_on_event_type_id"
    t.index ["user_id"], name: "index_feed_events_on_user_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_registrations_on_section_id"
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.text "text"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "curriculum_id"
    t.index ["curriculum_id"], name: "index_sections_on_curriculum_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_teacher", default: false
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attempts", "cards"
  add_foreign_key "attempts", "users"
  add_foreign_key "cards", "decks"
  add_foreign_key "cards", "resources"
  add_foreign_key "curriculums", "users"
  add_foreign_key "decks", "curriculums"
  add_foreign_key "feed_events", "decks"
  add_foreign_key "feed_events", "event_types"
  add_foreign_key "feed_events", "users"
  add_foreign_key "feed_events", "users", column: "about_user_id"
  add_foreign_key "registrations", "sections"
  add_foreign_key "registrations", "users"
  add_foreign_key "sections", "curriculums"
end
