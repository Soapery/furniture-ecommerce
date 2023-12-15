class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.order(:name)
  end

  def show
    @product = Product.find(params[:id])

    @variations = @product.product_variations
    @patterns = @product.product_patterns
  end

  def edit; end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    Rails.logger.debug product_params.inspect
    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path, notice: "Product was successfully deleted."
  end

  def search
    @products = if params[:search].present?
                  Product.where("name LIKE ?", "%#{params[:search]}%").page(params[:page]).per(10)
                else
                  Product.all.page(params[:page]).per(40)
                end
    render "home/index"
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :outdoor, :on_sale, :description)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
