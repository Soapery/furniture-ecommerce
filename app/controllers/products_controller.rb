class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_variations


  def index
    if params[:variation].present?
      @products = Product.joins(:product_variations).where('product_variations.variation_name = ?', params[:variation]).order(:name)
    else
      @products = Product.order(:name)
    end
  end

  def show
    @product = Product.find(params[:id])

    @variations = @product.product_variations
    @patterns = @product.product_patterns
  end

  def edit
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    puts product_params.inspect
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path, notice: 'Product was successfully deleted.'
  end


  def search

    puts "Search Param: #{params[:search]}"
    puts "Pattern Param: #{params[:pattern]}"
    @products = Product.includes(:product_patterns)

    if params[:search].present?
      @products = @products.where("name LIKE ?", "%#{params[:search]}%")
    end

    if params[:pattern].present?
      @products = @products.where(product_patterns: { pattern_name: params[:pattern] })
    end

    @products = @products.page(params[:page]).per(10)

    render 'home/index'
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :outdoor, :on_sale, :description)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
