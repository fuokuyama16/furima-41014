class AddNamesToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :name, :string, null: false, default: ""
    add_column :items, :description, :text, null: false
    add_column :items, :category_id, :integer, null: false
    add_column :items, :condition_id, :integer, null: false
    add_column :items, :shipping_cost_id, :integer, null: false
    add_column :items, :prefecture_id, :integer, null: false
    add_column :items, :shipping_day_id, :integer, null: false
    add_column :items, :price, :integer, null: false
  end
end
