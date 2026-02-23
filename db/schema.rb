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

ActiveRecord::Schema[8.1].define(version: 2026_02_23_082204) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "game_id", null: false
    t.bigint "pokemon_id", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_availabilities_on_game_id"
    t.index ["pokemon_id"], name: "index_availabilities_on_pokemon_id"
  end

  create_table "chats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "team_id", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_chats_on_team_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "name"
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "ability"
    t.datetime "created_at", null: false
    t.string "held_item"
    t.string "move_1"
    t.string "move_2"
    t.string "move_3"
    t.string "move_4"
    t.string "nature"
    t.bigint "pokemon_id", null: false
    t.bigint "team_id", null: false
    t.datetime "updated_at", null: false
    t.index ["pokemon_id"], name: "index_members_on_pokemon_id"
    t.index ["team_id"], name: "index_members_on_team_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "chat_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
  end

  create_table "playthroughs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "game_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["game_id"], name: "index_playthroughs_on_game_id"
    t.index ["user_id"], name: "index_playthroughs_on_user_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "name"
    t.string "type_1"
    t.string "type_2"
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "playthrough_id", null: false
    t.datetime "updated_at", null: false
    t.index ["playthrough_id"], name: "index_teams_on_playthrough_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "availabilities", "games"
  add_foreign_key "availabilities", "pokemons"
  add_foreign_key "chats", "teams"
  add_foreign_key "members", "pokemons"
  add_foreign_key "members", "teams"
  add_foreign_key "messages", "chats"
  add_foreign_key "playthroughs", "games"
  add_foreign_key "playthroughs", "users"
  add_foreign_key "teams", "playthroughs"
end
