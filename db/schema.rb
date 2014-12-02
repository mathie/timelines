# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141202081920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "authenticators", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "token"
    t.string   "secret"
    t.uuid     "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authenticators", ["provider", "uid"], name: "index_authenticators_on_provider_and_uid", unique: true, using: :btree
  add_index "authenticators", ["user_id"], name: "index_authenticators_on_user_id", using: :btree

  create_table "categories", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "title",       null: false
    t.uuid     "timeline_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "categories", ["timeline_id"], name: "index_categories_on_timeline_id", using: :btree

  create_table "eras", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.date     "started_on",  null: false
    t.date     "ended_on",    null: false
    t.string   "title",       null: false
    t.text     "body"
    t.uuid     "timeline_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "eras", ["timeline_id"], name: "index_eras_on_timeline_id", using: :btree

  create_table "events", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "title",         null: false
    t.text     "body"
    t.date     "started_on",    null: false
    t.date     "ended_on"
    t.uuid     "timeline_id",   null: false
    t.uuid     "category_id",   null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "image"
    t.string   "image_caption"
    t.string   "image_credit"
  end

  add_index "events", ["category_id"], name: "index_events_on_category_id", using: :btree
  add_index "events", ["timeline_id"], name: "index_events_on_timeline_id", using: :btree

  create_table "timelines", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "title",                               null: false
    t.text     "body",                                null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.uuid     "user_id",                             null: false
    t.string   "cover_image"
    t.string   "cover_image_caption"
    t.string   "cover_image_credit"
    t.boolean  "public",              default: false, null: false
  end

  add_index "timelines", ["user_id"], name: "index_timelines_on_user_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name",          null: false
    t.string   "email_address", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "users", ["email_address"], name: "index_users_on_email_address", unique: true, using: :btree

  add_foreign_key "authenticators", "users", on_update: :restrict, on_delete: :restrict
  add_foreign_key "categories", "timelines", on_update: :restrict, on_delete: :restrict
  add_foreign_key "eras", "timelines", on_update: :restrict, on_delete: :restrict
  add_foreign_key "events", "categories", on_update: :restrict, on_delete: :restrict
  add_foreign_key "events", "timelines", on_update: :restrict, on_delete: :restrict
  add_foreign_key "timelines", "users", on_update: :restrict, on_delete: :restrict
end
