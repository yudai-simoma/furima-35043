class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      #itemsテーブルに必要なカラムを追加
      t.string :product, null: false
      t.text :product_description, null: false
      t.integer :category_id, null: false
      t.integer :status_id, null: false
      t.integer :ship_base_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :ship_date_id, null: false
      t.integer :price, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
