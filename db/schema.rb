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

ActiveRecord::Schema.define(version: 20160203140853) do

  create_table "auth_infos", force: :cascade do |t|
    t.string   "password_digest",   limit: 255
    t.integer  "user_id",           limit: 4
    t.string   "remember_digest",   limit: 255
    t.string   "activation_digest", limit: 255
    t.boolean  "activated",         limit: 1,   default: false
    t.datetime "activated_at"
    t.string   "reset_digest",      limit: 255
    t.datetime "reset_sent_at"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "auth_infos", ["user_id"], name: "index_auth_infos_on_user_id", using: :btree

  create_table "blog_posts", force: :cascade do |t|
    t.boolean  "published",        limit: 1
    t.integer  "user_id",          limit: 4
    t.string   "title",            limit: 255
    t.text     "content",          limit: 65535
    t.string   "url",              limit: 255
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "content_markdown", limit: 1,     default: true
  end

  add_index "blog_posts", ["published_at"], name: "index_blog_posts_on_published_at", using: :btree
  add_index "blog_posts", ["url"], name: "index_blog_posts_on_url", unique: true, using: :btree

  create_table "blog_settings", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.string   "blog_name",         limit: 255, default: "INiMei Blog"
    t.string   "blog_subtitle",     limit: 255, default: "No subtitle"
    t.integer  "blogs_per_page",    limit: 4,   default: 10
    t.integer  "blog_preview_size", limit: 4,   default: 150
    t.string   "linkedin_url",      limit: 255
    t.string   "weibo_name",        limit: 255
    t.string   "domain",            limit: 255
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "blog_settings", ["domain"], name: "index_blog_settings_on_domain", unique: true, using: :btree
  add_index "blog_settings", ["user_id"], name: "index_blog_settings_on_user_id", using: :btree

  create_table "blog_taggings", force: :cascade do |t|
    t.integer "post_id", limit: 4
    t.integer "tag_id",  limit: 4
  end

  add_index "blog_taggings", ["post_id"], name: "index_blog_taggings_on_post_id", using: :btree
  add_index "blog_taggings", ["tag_id"], name: "index_blog_taggings_on_tag_id", using: :btree

  create_table "blog_tags", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "blog_tags", ["name"], name: "index_blog_tags_on_name", using: :btree

  create_table "microposts", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "picture",    limit: 255
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree
  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.text     "content",             limit: 65535
    t.datetime "completed_at"
    t.integer  "user_id",             limit: 4
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "completed",           limit: 1,     default: false
    t.datetime "planed_completed_at"
  end

  add_index "schedules", ["user_id"], name: "index_schedules_on_user_id", using: :btree

  create_table "sub_schedules", force: :cascade do |t|
    t.text     "content",     limit: 65535
    t.integer  "schedule_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "sub_schedules", ["schedule_id"], name: "index_sub_schedules_on_schedule_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",      limit: 1,   default: false
    t.string   "avatar",     limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "auth_infos", "users"
  add_foreign_key "blog_settings", "users"
  add_foreign_key "schedules", "users"
  add_foreign_key "sub_schedules", "schedules"
end
