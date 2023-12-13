class Product < ApplicationRecord
  has_many :orders, through: :order_product
  has_many :product_variations
  has_many :product_patterns

  validates :name, presence: true, length: { maxiumum: 50 }
  validates :description, presence: true, length: { maxiumum: 600 }
  validates :outdoor, presence: true
  validates :price, numericality: true, presence: true
  validates :on_sale, numericality: true, presence: true
end
