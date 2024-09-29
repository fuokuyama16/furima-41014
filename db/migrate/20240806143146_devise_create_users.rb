class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :users do |t|
      ## Database authenticatable
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end

  def down
    if index_exists?(:users, :reset_password_token)
      remove_index :users, :reset_password_token
    end
    if index_exists?(:users, :email)
      remove_index :users, :email
    end

    # 外部キー制約を無効化する
    execute 'SET FOREIGN_KEY_CHECKS = 0'
    drop_table :users if table_exists?(:users)
    execute 'SET FOREIGN_KEY_CHECKS = 1'
  end
end
