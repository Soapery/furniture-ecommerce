class Order < ApplicationRecord
  belongs_to :user
  has_many :products, through: :order_product

  validates :base_cost, presence: true, numericality: true
  validates :total_cost, presence: true, numericality: true
  validates :order_status, presence: true
end
