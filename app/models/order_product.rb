class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :amount, presence: true, numericality: true
  validates :base_cost, presence: true, numericality: true
  validates :gst, numericality: true, allow_nil: true
  validates :pst, numericality: true, allow_nil: true
  validates :hst, numericality: true, allow_nil: true
  validates :total_cost, presence: true, numericality: true
end
