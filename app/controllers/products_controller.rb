class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update]
  def show
    @product = Product.find(params[:id])
  end

  def edit
    # Renders the edit view
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :outdoor, :on_sale)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
