class Order < ApplicationRecord
  attr_accessor :credit_card_number, :credit_card_exp_month, :credit_card_exp_year, :credit_card_cvv

  belongs_to :user
  has_many :products, through: :order_product
  has_one :payment

  validates :base_cost, presence: true, numericality: true
  validates :total_cost, presence: true, numericality: true
  validates :order_status, presence: true

  after_create :create_payment
  def create_payment
    params = {
      order_id:              id,
      credit_card_number:,
      credit_card_exp_month:,
      credit_card_exp_year:,
      credit_card_cvv:
    }
    Payment.create!(params)
  end
end
