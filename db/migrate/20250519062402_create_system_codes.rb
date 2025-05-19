class CreateSystemCodes < ActiveRecord::Migration[8.0]
  def change
    create_table "system_codes", primary_key: ["code_type", "code"], force: :cascade do |t|
      t.string "code_type", limit: 20, null: false
      t.string "code", limit: 20, null: false
      t.string "code_desc", null: false
      t.integer "integer_value"
      t.string "alt_desc", limit: 500
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
