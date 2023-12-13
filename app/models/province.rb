class Province < ApplicationRecord
  has_many :players, dependent: :destroy

  validates :name, presence: true
  validates :gst, numericality: true, allow_nil: true
  validates :pst, numericality: true, allow_nil: true
  validates :hst, numericality: true, allow_nil: true
end
