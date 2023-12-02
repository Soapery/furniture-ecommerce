class CreateOrderProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :order_products do |t|
      t.integer :amount
      t.decimal :base_cost
      t.decimal :gst
      t.decimal :pst
      t.decimal :hst
      t.decimal :total_cost
      t.references :orders, null: false, foreign_key: true
      t.references :products, null: false, foreign_key: true

      t.timestamps
    end
  end
end
