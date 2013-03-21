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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130321134817) do

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "school_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string    "name"
    t.string    "teacher"
    t.string    "location"
    t.integer   "position"
    t.integer   "day"
    t.integer   "schedule_id"
    t.boolean   "week1",       :default => false
    t.boolean   "week2",       :default => false
    t.timestamp "created_at",                     :null => false
    t.timestamp "updated_at",                     :null => false
  end

  create_table "schedules", :force => true do |t|
    t.string    "name"
    t.integer   "user_id"
    t.timestamp "created_at",                          :null => false
    t.timestamp "updated_at",                          :null => false
    t.boolean   "weeks",         :default => false
    t.string    "slug"
    t.boolean   "weeks_counter", :default => false
    t.string    "local_time",    :default => "+00:00"
    t.integer   "weeks_count"
    t.string    "lesson1"
    t.string    "lesson2"
    t.string    "lesson3"
    t.string    "lesson4"
    t.string    "lesson5"
    t.string    "lesson6"
    t.integer   "group_id"
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "user_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "weeks_counter", :default => false
    t.string   "local_time",    :default => "+00:00"
    t.integer  "weeks_count"
  end

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "password_digest"
    t.timestamp "created_at",      :null => false
    t.timestamp "updated_at",      :null => false
    t.string    "remember_token"
  end

end
