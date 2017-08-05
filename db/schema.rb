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

ActiveRecord::Schema.define(version: 20170802143531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_assets", force: :cascade do |t|
    t.integer  "article_id"
    t.string   "description",        limit: 75
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "display_order"
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",         limit: 50
    t.text     "body"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "sticky",                   default: false
    t.integer  "display_order"
    t.boolean  "is_private"
  end

  create_table "block_captains", force: :cascade do |t|
    t.string   "description",   limit: 100
    t.integer  "user_id"
    t.integer  "display_order"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "board_members", force: :cascade do |t|
    t.string   "description",       limit: 25
    t.integer  "user_id"
    t.integer  "display_order"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "spouse"
    t.boolean  "include_last_name"
    t.date     "term_end"
  end

  create_table "item_assets", force: :cascade do |t|
    t.string   "item_type"
    t.integer  "item_id"
    t.string   "description",        limit: 75
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
  end

  add_index "item_assets", ["item_type", "item_id"], name: "index_item_assets_on_item_type_and_item_id", using: :btree

  create_table "mail_group_members", force: :cascade do |t|
    t.integer  "mail_group_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "mail_group_members", ["mail_group_id", "user_id"], name: "index_mail_group_members_on_mail_group_id_and_user_id", unique: true, using: :btree

  create_table "mail_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "residence_users", force: :cascade do |t|
    t.integer "residence_id"
    t.integer "user_id"
    t.boolean "is_resident",   default: true
    t.boolean "is_owner",      default: true
    t.integer "display_order", default: 1
  end

  add_index "residence_users", ["residence_id"], name: "index_residence_users_on_residence_id", using: :btree
  add_index "residence_users", ["user_id"], name: "index_residence_users_on_user_id", using: :btree

  create_table "residences", force: :cascade do |t|
    t.integer  "street_number"
    t.integer  "street_id"
    t.integer  "lot"
    t.integer  "block"
    t.integer  "purchase_year"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "block_captain_id"
  end

  add_index "residences", ["block_captain_id"], name: "index_residences_on_block_captain_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "streets", force: :cascade do |t|
    t.string   "street_name", limit: 30
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "last_name",               limit: 50
    t.string   "first_name",              limit: 50
    t.string   "phone",                   limit: 15
    t.boolean  "email_is_private"
    t.boolean  "spouse_email_is_private"
    t.boolean  "phone_is_private"
    t.boolean  "spouse_phone_is_private"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
