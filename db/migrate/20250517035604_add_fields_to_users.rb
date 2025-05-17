class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :first_name, :string, null: false, limit: 50
    add_column :users, :last_name, :string, null: false, limit: 50
    add_column :users, :mobile_phone, :string, null: false, limit: 15
    add_column :users, :created_by, :bigint, null: false
    add_column :users, :updated_by, :bigint, null: false
  end
end
