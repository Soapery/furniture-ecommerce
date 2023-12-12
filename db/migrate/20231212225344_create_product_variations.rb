class CreateProductVariations < ActiveRecord::Migration[7.0]
  def change
    create_table :product_variations do |t|
      t.references :product, null: false, foreign_key: true
      t.text :variation_name

      t.timestamps
    end
  end
end
