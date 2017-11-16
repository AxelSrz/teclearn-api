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

ActiveRecord::Schema.define(version: 20171116014818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempt_answers", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "attempt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "answer"
    t.boolean "is_correct"
    t.index ["attempt_id"], name: "index_attempt_answers_on_attempt_id"
    t.index ["question_id"], name: "index_attempt_answers_on_question_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "quiz_id"
    t.float "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.index ["group_id"], name: "index_attempts_on_group_id"
    t.index ["quiz_id"], name: "index_attempts_on_quiz_id"
    t.index ["student_id"], name: "index_attempts_on_student_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "professor_id"
    t.string "name"
    t.string "access_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.index ["professor_id"], name: "index_groups_on_professor_id"
  end

  create_table "professors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_salt"
  end

  create_table "question_to_quiz_assignations", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "quiz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_to_quiz_assignations_on_question_id"
    t.index ["quiz_id"], name: "index_question_to_quiz_assignations_on_quiz_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "professor_id"
    t.string "question_description"
    t.string "option_1"
    t.string "option_2"
    t.string "option_3"
    t.string "option_4"
    t.string "option_5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professor_id"], name: "index_questions_on_professor_id"
  end

  create_table "quiz_to_group_assignations", force: :cascade do |t|
    t.bigint "quiz_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expires_at"
    t.index ["group_id"], name: "index_quiz_to_group_assignations_on_group_id"
    t.index ["quiz_id"], name: "index_quiz_to_group_assignations_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.bigint "professor_id"
    t.string "resource_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "resource_type"
    t.index ["professor_id"], name: "index_quizzes_on_professor_id"
  end

  create_table "student_to_group_assignations", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_student_to_group_assignations_on_group_id"
    t.index ["student_id"], name: "index_student_to_group_assignations_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_salt"
    t.string "state"
    t.integer "on_use_identifier"
  end

  create_table "tag_to_question_assignations", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_tag_to_question_assignations_on_question_id"
    t.index ["tag_id"], name: "index_tag_to_question_assignations_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.bigint "professor_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professor_id"], name: "index_tags_on_professor_id"
  end

  add_foreign_key "attempts", "groups"
end
