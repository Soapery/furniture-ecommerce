class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])

    @variations = @product.product_variations
    @patterns = @product.product_patterns
  end
end
