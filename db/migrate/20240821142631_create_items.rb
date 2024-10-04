class CreateItems < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:items)
      create_table :items do |t|
        t.references :user, null: false, foreign_key: true
        t.timestamps
      end
    end
  end
end
