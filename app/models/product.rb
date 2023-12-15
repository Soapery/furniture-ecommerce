class Product < ApplicationRecord
  has_many :order_products
  has_many :orders, through: :order_products
  has_many :product_variations
  has_many :product_patterns

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 600 }
  validates :outdoor, inclusion: [true, false]
  validates :price, numericality: true, presence: true
  validates :on_sale, numericality: true, presence: true
end
