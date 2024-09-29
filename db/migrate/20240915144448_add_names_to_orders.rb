class AddNamesToOrders < ActiveRecord::Migration[7.0]
  def change
      add_column :orders, :postal_code, :string, null: false, default: ""
      add_column :orders, :prefecture_id, :integer, null: false
      add_column :orders, :city, :string, null: false, default: ""
      add_column :orders, :street, :string, null: false, default: ""
      add_column :orders, :building, :string
      add_column :orders, :phone_number, :string, null: false, default: ""
      add_column :orders, :token, :string, null: false
  end
end
