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

ActiveRecord::Schema.define(version: 2018_09_08_181805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gin"
  enable_extension "btree_gist"
  enable_extension "plpgsql"

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "comment", null: false
    t.integer "story_id", null: false
    t.integer "user_id", null: false
    t.integer "parent_id"
    t.integer "upvotes", default: 0, null: false
    t.integer "downvotes", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "confidence", precision: 20, scale: 19
    t.text "markeddown_comment"
    t.boolean "is_deleted", default: false
    t.boolean "is_moderated", default: false
    t.boolean "is_from_email", default: false
    t.integer "hat_id"
    t.string "short_id", limit: 10, default: "", null: false
    t.integer "thread_id"
    t.string "ancestry"
    t.index ["ancestry"], name: "index_comments_on_ancestry"
    t.index ["comment"], name: "index_comments_on_comment", using: :gin
    t.index ["confidence"], name: "confidence_idx"
    t.index ["short_id"], name: "index_comments_on_short_id", unique: true
    t.index ["thread_id"], name: "index_comments_on_thread_id"
    t.index ["user_id", "story_id", "downvotes", "created_at"], name: "downvote_index"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "hat_requests", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "hat"
    t.string "link"
    t.text "comment"
  end

  create_table "hats", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "granted_by_user_id"
    t.string "hat", null: false
    t.string "link"
    t.boolean "modlog_use", default: false
    t.datetime "doffed_at"
  end

  create_table "hidden_stories", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "story_id"
    t.index ["user_id", "story_id"], name: "index_hidden_stories_on_user_id_and_story_id", unique: true
  end

  create_table "invitation_requests", id: :serial, force: :cascade do |t|
    t.string "code"
    t.boolean "is_verified", default: false
    t.string "email"
    t.string "name"
    t.text "memo"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "email"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "memo"
    t.datetime "used_at"
    t.integer "new_user_id"
  end

  create_table "keystores", id: :serial, force: :cascade do |t|
    t.bigint "value"
    t.string "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.string "short_id"
    t.boolean "has_been_read", default: false
    t.integer "author_user_id"
    t.integer "recipient_user_id"
    t.string "subject", limit: 99
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "deleted_by_author", default: false
    t.boolean "deleted_by_recipient", default: false
    t.bigint "hat_id"
    t.index ["hat_id"], name: "index_messages_on_hat_id"
  end

  create_table "mod_notes", force: :cascade do |t|
    t.integer "moderator_user_id", null: false
    t.integer "user_id", null: false
    t.text "note", null: false
    t.text "markeddown_note", null: false
    t.datetime "created_at", null: false
    t.index ["id", "user_id"], name: "index_mod_notes_on_id_and_user_id"
  end

  create_table "moderations", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "moderator_user_id"
    t.integer "story_id"
    t.integer "comment_id"
    t.integer "user_id"
    t.text "action"
    t.text "reason"
    t.boolean "is_from_suggestions", default: false
    t.integer "tag_id"
    t.index ["created_at"], name: "index_moderations_on_created_at"
  end

  create_table "read_ribbons", force: :cascade do |t|
    t.boolean "is_following", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "story_id"
    t.index ["story_id"], name: "index_read_ribbons_on_story_id"
    t.index ["user_id"], name: "index_read_ribbons_on_user_id"
  end

  create_table "saved_stories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "story_id"
    t.index ["user_id", "story_id"], name: "index_saved_stories_on_user_id_and_story_id", unique: true
  end

  create_table "stories", id: :serial, force: :cascade do |t|
    t.string "url", limit: 250, default: ""
    t.string "title", limit: 150, default: "", null: false
    t.text "description"
    t.boolean "is_expired", default: false, null: false
    t.boolean "is_moderated", default: false, null: false
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "short_id", limit: 6, default: "", null: false
    t.integer "upvotes", default: 0, null: false
    t.integer "downvotes", default: 0, null: false
    t.decimal "hotness", precision: 20, scale: 10
    t.text "markeddown_description"
    t.text "story_cache"
    t.integer "comments_count", default: 0, null: false
    t.integer "merged_story_id"
    t.datetime "unavailable_at"
    t.string "twitter_id", limit: 20
    t.boolean "user_is_author", default: false
    t.index ["created_at"], name: "index_stories_on_created_at"
    t.index ["description"], name: "index_stories_on_description", using: :gin
    t.index ["hotness"], name: "hotness_idx"
    t.index ["is_expired", "is_moderated"], name: "is_idxes"
    t.index ["merged_story_id"], name: "index_stories_on_merged_story_id"
    t.index ["short_id"], name: "unique_short_id", unique: true
    t.index ["story_cache"], name: "index_stories_on_story_cache", using: :gin
    t.index ["title"], name: "index_stories_on_title", using: :gin
    t.index ["twitter_id"], name: "index_stories_on_twitter_id"
    t.index ["url"], name: "url"
    t.index ["user_id"], name: "index_stories_on_user_id"
  end

  create_table "story_saves", force: :cascade do |t|
    t.bigint "story_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id", "user_id"], name: "index_story_saves_on_story_id_and_user_id", unique: true
    t.index ["story_id"], name: "index_story_saves_on_story_id"
    t.index ["user_id"], name: "index_story_saves_on_user_id"
  end

  create_table "story_votes", force: :cascade do |t|
    t.bigint "story_id"
    t.bigint "user_id"
    t.integer "vote_score", null: false
    t.datetime "upvoted_at"
    t.datetime "downvoted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id", "user_id"], name: "index_story_votes_on_story_id_and_user_id", unique: true
    t.index ["story_id"], name: "index_story_votes_on_story_id"
    t.index ["user_id"], name: "index_story_votes_on_user_id"
  end

  create_table "suggested_taggings", id: :serial, force: :cascade do |t|
    t.integer "story_id"
    t.integer "tag_id"
    t.integer "user_id"
  end

  create_table "suggested_titles", id: :serial, force: :cascade do |t|
    t.integer "story_id"
    t.integer "user_id"
    t.string "title", limit: 150, null: false
  end

  create_table "tag_filters", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "tag_id"
    t.index ["user_id", "tag_id"], name: "user_tag_idx"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "story_id", null: false
    t.integer "tag_id", null: false
    t.index ["story_id", "tag_id"], name: "story_id_tag_id", unique: true
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "tag", limit: 25, null: false
    t.string "description", limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "privileged", default: false
    t.boolean "is_media", default: false
    t.boolean "inactive", default: false
    t.float "hotness_mod", default: 0.0
    t.string "background_color", default: "#fef2c0"
    t.string "text_color", default: "#000"
    t.index ["tag"], name: "tag", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", limit: 50
    t.string "email", limit: 100
    t.string "password_digest", limit: 75
    t.datetime "created_at"
    t.boolean "is_admin", default: false
    t.string "password_reset_token", limit: 75
    t.string "session_token", limit: 75, default: "", null: false
    t.text "about"
    t.integer "invited_by_user_id"
    t.boolean "email_replies", default: false
    t.boolean "pushover_replies", default: false
    t.string "pushover_user_key"
    t.boolean "email_messages", default: true
    t.boolean "pushover_messages", default: true
    t.boolean "is_moderator", default: false
    t.boolean "email_mentions", default: false
    t.boolean "pushover_mentions", default: false
    t.string "rss_token"
    t.string "mailing_list_token"
    t.integer "mailing_list_mode", default: 0
    t.integer "karma", default: 0, null: false
    t.datetime "banned_at"
    t.integer "banned_by_user_id"
    t.string "banned_reason", limit: 200
    t.datetime "deleted_at"
    t.boolean "show_avatars", default: false
    t.boolean "show_story_previews", default: false
    t.boolean "show_submitted_story_threads", default: true
    t.datetime "disabled_invite_at"
    t.integer "disabled_invite_by_user_id"
    t.string "disabled_invite_reason", limit: 200
    t.text "settings"
    t.string "github_uid"
    t.string "github_oauth_token"
    t.index ["github_uid"], name: "index_users_on_github_uid", unique: true
    t.index ["mailing_list_mode"], name: "index_users_on_mailing_list_mode"
    t.index ["password_reset_token"], name: "password_reset_token", unique: true
    t.index ["session_token"], name: "session_hash", unique: true
    t.index ["username"], name: "username", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "story_id", null: false
    t.integer "comment_id"
    t.integer "vote", limit: 2, null: false
    t.string "reason", limit: 1
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_votes_on_comment_id"
    t.index ["user_id", "comment_id"], name: "user_id_comment_id"
    t.index ["user_id", "story_id"], name: "user_id_story_id"
  end

  add_foreign_key "story_saves", "stories"
  add_foreign_key "story_saves", "users"
  add_foreign_key "story_votes", "stories"
  add_foreign_key "story_votes", "users"

  create_view "replying_comments",  sql_definition: <<-SQL
      SELECT read_ribbons.user_id,
      comments.id AS comment_id,
      read_ribbons.story_id,
      comments.parent_id AS parent_comment_id,
      comments.created_at AS comment_created_at,
      parent_comments.user_id AS parent_comment_author_id,
      comments.user_id AS comment_author_id,
      stories.user_id AS story_author_id,
      (read_ribbons.updated_at < comments.created_at) AS is_unread,
      ( SELECT votes.vote
             FROM votes
            WHERE ((votes.user_id = read_ribbons.user_id) AND (votes.comment_id = comments.id))) AS current_vote_vote,
      ( SELECT votes.reason
             FROM votes
            WHERE ((votes.user_id = read_ribbons.user_id) AND (votes.comment_id = comments.id))) AS current_vote_reason
     FROM (((read_ribbons
       JOIN comments ON ((comments.story_id = read_ribbons.story_id)))
       JOIN stories ON ((stories.id = comments.story_id)))
       LEFT JOIN comments parent_comments ON ((parent_comments.id = comments.parent_id)))
    WHERE ((read_ribbons.is_following = true) AND (comments.user_id <> read_ribbons.user_id) AND (comments.is_deleted = false) AND (comments.is_moderated = false) AND ((parent_comments.user_id = read_ribbons.user_id) OR ((parent_comments.user_id IS NULL) AND (stories.user_id = read_ribbons.user_id))) AND ((comments.upvotes - comments.downvotes) >= 0) AND ((parent_comments.id IS NULL) OR ((parent_comments.upvotes - parent_comments.downvotes) >= 0)));
  SQL

end
