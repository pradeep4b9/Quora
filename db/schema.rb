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

ActiveRecord::Schema.define(:version => 20160304093836) do

  create_table "answers", :force => true do |t|
    t.text     "body"
    t.integer  "votes"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "answer_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["answer_id"], :name => "index_comments_on_answer_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "question_topics", :force => true do |t|
    t.integer  "question_id"
    t.integer  "topic_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "question_topics", ["question_id", "topic_id"], :name => "index_question_topics_on_question_id_and_topic_id", :unique => true
  add_index "question_topics", ["question_id"], :name => "index_question_topics_on_question_id"
  add_index "question_topics", ["topic_id"], :name => "index_question_topics_on_topic_id"

  create_table "questions", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.integer  "votes"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_topics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_topics", ["topic_id"], :name => "index_user_topics_on_topic_id"
  add_index "user_topics", ["user_id", "topic_id"], :name => "index_user_topics_on_user_id_and_topic_id", :unique => true
  add_index "user_topics", ["user_id"], :name => "index_user_topics_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
