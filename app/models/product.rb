class Product < ApplicationRecord
  has_many :orders, through: :order_product
end
