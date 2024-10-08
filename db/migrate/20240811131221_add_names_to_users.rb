class AddNamesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nickname, :string, null: false, default: ""
    add_column :users, :first_name, :string, null: false, default: ""
    add_column :users, :last_name, :string, null: false, default: ""
    add_column :users, :last_name_kana, :string, null: false, default: ""
    add_column :users, :first_name_kana, :string, null: false, default: ""
    add_column :users, :birth_date, :date, null: false
  end
end
