class ProductVariation < ApplicationRecord
  belongs_to :product

  validates :variation_name, presence: true
end
