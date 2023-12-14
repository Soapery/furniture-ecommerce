class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, limit: 50
      t.boolean :outdoor
      t.decimal :price
      t.decimal :on_sale
      t.string  :description, limit: 600

      t.timestamps
    end
  end
end
