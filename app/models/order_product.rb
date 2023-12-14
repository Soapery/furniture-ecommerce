class OrderProduct < ApplicationRecord
  belongs_to :orders
  belongs_to :products

  validates :amount, presence: true, numericality: true
  validates :base_cost, presence: true, numericality: true
  validates :gst, numericality: true, allow_nil: true
  validates :pst, numericality: true, allow_nil: true
  validates :hst, numericality: true, allow_nil: true
  validates :total_cost, presence: true, numericality: true
end
