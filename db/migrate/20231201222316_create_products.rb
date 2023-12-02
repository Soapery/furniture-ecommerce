class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|

      t.string :name, limit: 50
      t.string :variation, limit: 50
      t.string :pattern, limit: 50
      t.boolean :outdoor
      t.decimal :price
      t.decimal :on_sale


      t.timestamps
    end
  end
end
