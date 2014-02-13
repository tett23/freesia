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

ActiveRecord::Schema.define(version: 0) do

  create_table :users, force: true do |t|
    t.string :username, :default => ""
    t.string :provider, :null => false, :default => "database"
    t.string :uid,      :null => false, :default => ""
    t.string :email
    t.integer  :sign_in_count, :default => 0, :null => false
    t.datetime :current_sign_in_at
    t.datetime :last_sign_in_at
    t.string   :current_sign_in_ip
    t.string   :last_sign_in_ip
    t.datetime :remember_created_at
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index :users, :username

  create_table "data_column_datasets", id: false, force: true do |t|
    t.integer "dataset_id", null: false
    t.integer "column_id",  null: false
  end

  add_index "data_column_datasets", ["column_id"], name: "data_column_datasets_column_fk", using: :btree

  create_table "data_columns", force: true do |t|
    t.string  "name"
    t.boolean "type"
    t.text    "remark"
    t.integer "account_id"
  end

  add_index "data_columns", ["account_id"], name: "index_data_columns_account", using: :btree

  create_table "dataset_journals", force: true do |t|
    t.integer "dataset_id", null: false
    t.integer "journal_id", null: false
  end

  add_index "dataset_journals", ["dataset_id"], name: "index_dataset_journals_dataset", using: :btree
  add_index "dataset_journals", ["journal_id"], name: "index_dataset_journals_journal", using: :btree

  create_table "datasets", force: true do |t|
    t.string  "name"
    t.text    "remark"
    t.integer "account_id"
  end

  add_index "datasets", ["account_id"], name: "index_datasets_account", using: :btree

  create_table "journal_data", force: true do |t|
    t.text    "value"
    t.integer "journal_id",     null: false
    t.integer "dataset_id",     null: false
    t.integer "data_column_id", null: false
  end

  add_index "journal_data", ["data_column_id"], name: "index_journal_data_data_column", using: :btree
  add_index "journal_data", ["dataset_id"], name: "index_journal_data_dataset", using: :btree
  add_index "journal_data", ["journal_id"], name: "index_journal_data_journal", using: :btree

  create_table "journals", force: true do |t|
    t.integer "account_id"
    t.integer "notebook_id", null: false
  end

  add_index "journals", ["account_id"], name: "index_journals_account", using: :btree
  add_index "journals", ["notebook_id"], name: "index_journals_notebook", using: :btree

  create_table "notebooks", force: true do |t|
    t.string  "name"
    t.string  "slug",       limit: 2000
    t.text    "remark"
    t.integer "account_id"
  end

  add_index "notebooks", ["account_id"], name: "index_notebooks_account", using: :btree

end
