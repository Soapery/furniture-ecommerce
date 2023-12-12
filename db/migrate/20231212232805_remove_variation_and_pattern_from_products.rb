class RemoveVariationAndPatternFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :variation, :string
    remove_column :products, :pattern, :string
  end
end
