class InitialDatabase < ActiveRecord::Migration[8.0]
  def change
    create_table "action_text_rich_texts", force: :cascade do |t|
      t.string "name", null: false
      t.text "body"
      t.string "record_type", null: false
      t.bigint "record_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
    end

    create_table "active_storage_attachments", force: :cascade do |t|
      t.string "name", null: false
      t.string "record_type", null: false
      t.bigint "record_id", null: false
      t.bigint "blob_id", null: false
      t.datetime "created_at", null: false
      t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
      t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
    end

    create_table "active_storage_blobs", force: :cascade do |t|
      t.string "key", null: false
      t.string "filename", null: false
      t.string "content_type"
      t.text "metadata"
      t.string "service_name", null: false
      t.bigint "byte_size", null: false
      t.string "checksum"
      t.datetime "created_at", null: false
      t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
    end

    create_table "active_storage_variant_records", force: :cascade do |t|
      t.bigint "blob_id", null: false
      t.string "variation_digest", null: false
      t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
    end

    create_table "roles", force: :cascade do |t|
      t.string "name"
      t.string "resource_type"
      t.bigint "resource_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
      t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
    end

    create_table "system_codes", primary_key: ["code_type", "code"], force: :cascade do |t|
      t.string "code_type", limit: 20, null: false
      t.string "code", limit: 20, null: false
      t.string "code_desc", null: false
      t.integer "integer_value"
      t.string "alt_desc", limit: 500
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 100, default: "", null: false
    t.string "first_name", limit: 50, null: false
    t.string "last_name", limit: 50, null: false
    t.string "mobile_phone", limit: 20, null: false
    t.string "time_zone", limit: 50, default: "Melbourne", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
    t.string "unlock_token"
    t.boolean "active", default: true, null: false
    t.bigint "created_by", null: false
    t.bigint "updated_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end


    create_table "users_roles", id: false, force: :cascade do |t|
      t.bigint "user_id"
      t.bigint "role_id"
      t.index ["role_id"], name: "index_users_roles_on_role_id"
      t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
      t.index ["user_id"], name: "index_users_roles_on_user_id"
    end

    add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
    add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"

  end
end
