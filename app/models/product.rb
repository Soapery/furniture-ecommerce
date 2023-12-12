class Product < ApplicationRecord
  has_many :orders, through: :order_product
  has_many :product_variations
  has_many :product_patterns
end
