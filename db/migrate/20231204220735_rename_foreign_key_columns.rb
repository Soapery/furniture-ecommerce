class RenameForeignKeyColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :order_products, :orders_id, :order_id
    rename_column :order_products, :products_id, :product_id
    rename_column :users, :provinces_id, :province_id
  end
end
