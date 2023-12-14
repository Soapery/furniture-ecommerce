class AddPaymentMethodToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :payment_method, :string
    add_column :orders, :status, :string
  end
end
