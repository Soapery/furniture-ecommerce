class Order < ApplicationRecord
  attr_accessor :credit_card_number, :credit_card_exp, :credit_card_cvv

  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products
  has_one :payment

  validates :base_cost, presence: true, numericality: true
  validates :total_cost, presence: true, numericality: true
  validates :order_status, presence: true
end
