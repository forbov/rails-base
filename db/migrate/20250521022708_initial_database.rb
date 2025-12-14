class InitialDatabase < ActiveRecord::Migration[8.0]
  def change
    create_table "action_text_rich_texts", force: :cascade do |t|
      t.string "name", null: false
      t.text "body"
      t.string "record_type", null: false
      t.bigint "record_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index [ "record_type", "record_id", "name" ], name: "index_action_text_rich_texts_uniqueness", unique: true
    end

    create_table "active_storage_attachments", force: :cascade do |t|
      t.string "name", null: false
      t.string "record_type", null: false
      t.bigint "record_id", null: false
      t.bigint "blob_id", null: false
      t.datetime "created_at", null: false
      t.index [ "blob_id" ], name: "index_active_storage_attachments_on_blob_id"
      t.index [ "record_type", "record_id", "name", "blob_id" ], name: "index_active_storage_attachments_uniqueness", unique: true
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
      t.index [ "key" ], name: "index_active_storage_blobs_on_key", unique: true
    end

    create_table "active_storage_variant_records", force: :cascade do |t|
      t.bigint "blob_id", null: false
      t.string "variation_digest", null: false
      t.index [ "blob_id", "variation_digest" ], name: "index_active_storage_variant_records_uniqueness", unique: true
    end

    create_table "help_pages", force: :cascade do |t|
      t.string "title", limit: 30, null: false
      t.integer "page_order", null: false
      t.boolean "active", default: true, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "roles", force: :cascade do |t|
      t.string "name"
      t.string "resource_type"
      t.bigint "resource_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index [ "name", "resource_type", "resource_id" ], name: "index_roles_on_name_and_resource_type_and_resource_id"
      t.index [ "resource_type", "resource_id" ], name: "index_roles_on_resource"
    end

    create_table "system_codes", primary_key: [ "code_type", "code" ], force: :cascade do |t|
      t.string "code_type", limit: 20, null: false
      t.string "code", limit: 20, null: false
      t.string "code_desc", null: false
      t.integer "integer_value"
      t.string "alt_desc", limit: 500
      t.string "alt_desc2", limit: 255
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "users", force: :cascade do |t|
      t.string "email", limit: 100, default: "", null: false
      t.string "first_name", limit: 50, null: false
      t.string "last_name", limit: 50, null: false
      t.string "mobile_phone", limit: 20, null: false
      t.string "encrypted_password", default: "", null: false
      t.string "time_zone", limit: 50, default: "Melbourne", null: false
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
      t.string "otp_secret"
      t.integer "consumed_timestep"
      t.boolean "otp_required_for_login"
      t.string "api_token"
      t.boolean "active", default: true, null: false
      t.bigint "created_by", null: false
      t.bigint "updated_by", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index [ "api_token" ], name: "index_users_on_api_token", unique: true
      t.index [ "email" ], name: "index_users_on_email", unique: true
      t.index [ "invitation_token" ], name: "index_users_on_invitation_token", unique: true
      t.index [ "invited_by_id" ], name: "index_users_on_invited_by_id"
      t.index [ "invited_by_type", "invited_by_id" ], name: "index_users_on_invited_by"
      t.index [ "reset_password_token" ], name: "index_users_on_reset_password_token", unique: true
      t.index [ "unlock_token" ], name: "index_users_on_unlock_token", unique: true
    end

    create_table "users_roles", id: false, force: :cascade do |t|
      t.bigint "user_id"
      t.bigint "role_id"
      t.index [ "role_id" ], name: "index_users_roles_on_role_id"
      t.index [ "user_id", "role_id" ], name: "index_users_roles_on_user_id_and_role_id"
      t.index [ "user_id" ], name: "index_users_roles_on_user_id"
    end

    create_table "solid_queue_blocked_executions", force: :cascade do |t|
      t.bigint "job_id", null: false
      t.string "queue_name", null: false
      t.integer "priority", default: 0, null: false
      t.string "concurrency_key", null: false
      t.datetime "expires_at", null: false
      t.datetime "created_at", null: false
      t.index [ "concurrency_key", "priority", "job_id" ], name: "index_solid_queue_blocked_executions_for_release"
      t.index [ "expires_at", "concurrency_key" ], name: "index_solid_queue_blocked_executions_for_maintenance"
      t.index [ "job_id" ], name: "index_solid_queue_blocked_executions_on_job_id", unique: true
    end

    create_table "solid_queue_claimed_executions", force: :cascade do |t|
      t.bigint "job_id", null: false
      t.bigint "process_id"
      t.datetime "created_at", null: false
      t.index [ "job_id" ], name: "index_solid_queue_claimed_executions_on_job_id", unique: true
      t.index [ "process_id", "job_id" ], name: "index_solid_queue_claimed_executions_on_process_id_and_job_id"
    end

    create_table "solid_queue_failed_executions", force: :cascade do |t|
      t.bigint "job_id", null: false
      t.text "error"
      t.datetime "created_at", null: false
      t.index [ "job_id" ], name: "index_solid_queue_failed_executions_on_job_id", unique: true
    end

    create_table "solid_queue_jobs", force: :cascade do |t|
      t.string "queue_name", null: false
      t.string "class_name", null: false
      t.text "arguments"
      t.integer "priority", default: 0, null: false
      t.string "active_job_id"
      t.datetime "scheduled_at"
      t.datetime "finished_at"
      t.string "concurrency_key"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index [ "active_job_id" ], name: "index_solid_queue_jobs_on_active_job_id"
      t.index [ "class_name" ], name: "index_solid_queue_jobs_on_class_name"
      t.index [ "finished_at" ], name: "index_solid_queue_jobs_on_finished_at"
      t.index [ "queue_name", "finished_at" ], name: "index_solid_queue_jobs_for_filtering"
      t.index [ "scheduled_at", "finished_at" ], name: "index_solid_queue_jobs_for_alerting"
    end

    create_table "solid_queue_pauses", force: :cascade do |t|
      t.string "queue_name", null: false
      t.datetime "created_at", null: false
      t.index [ "queue_name" ], name: "index_solid_queue_pauses_on_queue_name", unique: true
    end

    create_table "solid_queue_processes", force: :cascade do |t|
      t.string "kind", null: false
      t.datetime "last_heartbeat_at", null: false
      t.bigint "supervisor_id"
      t.integer "pid", null: false
      t.string "hostname"
      t.text "metadata"
      t.datetime "created_at", null: false
      t.string "name", null: false
      t.index [ "last_heartbeat_at" ], name: "index_solid_queue_processes_on_last_heartbeat_at"
      t.index [ "name", "supervisor_id" ], name: "index_solid_queue_processes_on_name_and_supervisor_id", unique: true
      t.index [ "supervisor_id" ], name: "index_solid_queue_processes_on_supervisor_id"
    end

    create_table "solid_queue_ready_executions", force: :cascade do |t|
      t.bigint "job_id", null: false
      t.string "queue_name", null: false
      t.integer "priority", default: 0, null: false
      t.datetime "created_at", null: false
      t.index [ "job_id" ], name: "index_solid_queue_ready_executions_on_job_id", unique: true
      t.index [ "priority", "job_id" ], name: "index_solid_queue_poll_all"
      t.index [ "queue_name", "priority", "job_id" ], name: "index_solid_queue_poll_by_queue"
    end

    create_table "solid_queue_recurring_executions", force: :cascade do |t|
      t.bigint "job_id", null: false
      t.string "task_key", null: false
      t.datetime "run_at", null: false
      t.datetime "created_at", null: false
      t.index [ "job_id" ], name: "index_solid_queue_recurring_executions_on_job_id", unique: true
      t.index [ "task_key", "run_at" ], name: "index_solid_queue_recurring_executions_on_task_key_and_run_at", unique: true
    end

    create_table "solid_queue_recurring_tasks", force: :cascade do |t|
      t.string "key", null: false
      t.string "schedule", null: false
      t.string "command", limit: 2048
      t.string "class_name"
      t.text "arguments"
      t.string "queue_name"
      t.integer "priority", default: 0
      t.boolean "static", default: true, null: false
      t.text "description"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index [ "key" ], name: "index_solid_queue_recurring_tasks_on_key", unique: true
      t.index [ "static" ], name: "index_solid_queue_recurring_tasks_on_static"
    end

    create_table "solid_queue_scheduled_executions", force: :cascade do |t|
      t.bigint "job_id", null: false
      t.string "queue_name", null: false
      t.integer "priority", default: 0, null: false
      t.datetime "scheduled_at", null: false
      t.datetime "created_at", null: false
      t.index [ "job_id" ], name: "index_solid_queue_scheduled_executions_on_job_id", unique: true
      t.index [ "scheduled_at", "priority", "job_id" ], name: "index_solid_queue_dispatch_all"
    end

    create_table "solid_queue_semaphores", force: :cascade do |t|
      t.string "key", null: false
      t.integer "value", default: 1, null: false
      t.datetime "expires_at", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index [ "expires_at" ], name: "index_solid_queue_semaphores_on_expires_at"
      t.index [ "key", "value" ], name: "index_solid_queue_semaphores_on_key_and_value"
      t.index [ "key" ], name: "index_solid_queue_semaphores_on_key", unique: true
    end

    add_foreign_key "solid_queue_blocked_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
    add_foreign_key "solid_queue_claimed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
    add_foreign_key "solid_queue_failed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
    add_foreign_key "solid_queue_ready_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
    add_foreign_key "solid_queue_recurring_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
    add_foreign_key "solid_queue_scheduled_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
    add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
    add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  end
end
