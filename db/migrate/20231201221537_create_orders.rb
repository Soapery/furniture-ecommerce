class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|

    #  t.reference :user, null: false, foreign_key: true
      t.decimal :base_cost
      t.decimal :total_cost
      t.string :order_status, limit: 50

      t.timestamps
    end
  end
end
