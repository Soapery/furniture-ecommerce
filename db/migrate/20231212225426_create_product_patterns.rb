class CreateProductPatterns < ActiveRecord::Migration[7.0]
  def change
    create_table :product_patterns do |t|
      t.references :product, null: false, foreign_key: true
      t.text :pattern_name

      t.timestamps
    end
  end
end
