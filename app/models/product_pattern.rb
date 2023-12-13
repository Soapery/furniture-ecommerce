class ProductPattern < ApplicationRecord
  belongs_to :product

  validates :pattern_name, presence: true
end
