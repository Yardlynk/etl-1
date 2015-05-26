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

ActiveRecord::Schema.define(version: 20150526182447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "job_run_statuses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "label",      null: false
    t.string   "name",       null: false
  end

  create_table "job_runs", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "job_id",            null: false
    t.integer  "job_run_status_id", null: false
    t.datetime "run_start_time"
    t.datetime "run_end_time"
    t.datetime "batch_date"
    t.integer  "num_rows_success"
    t.integer  "num_rows_error"
  end

  add_index "job_runs", ["job_id"], name: "index_job_runs_on_job_id", using: :btree
  add_index "job_runs", ["job_run_status_id"], name: "index_job_runs_on_job_run_status_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "class_name", null: false
  end

  add_foreign_key "job_runs", "job_run_statuses"
  add_foreign_key "job_runs", "jobs"
end
