class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :set_variations

  def index
    @products = if params[:variation].present?
                  Product.joins(:product_variations).where("product_variations.variation_name = ?",
                                                           params[:variation]).order(:name)
                else
                  Product.order(:name)
                end
  end

  def show
    @product = Product.find(params[:id])

    @variations = @product.product_variations
    @patterns = @product.product_patterns
  end

  def edit; end

  def update
    @product = Product.find(params[:id])
    pattern_names = params[:product][:pattern_names] # Fetch selected pattern names from params

    # Clear existing associations to reassign the patterns
    @product.product_patterns.destroy_all

    if @product.update(product_params)
      # Associate each selected pattern with the updated product
      pattern_names.each do |pattern_name|
        selected_pattern = ProductPattern.find_by(pattern_name:)
        @product.product_patterns.create(pattern_name:) if selected_pattern
      end

      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit
    end
  end

  def new
    @product = Product.new
    @patterns = ProductPattern.pluck(:pattern_name, :id) # Fetch pattern names and IDs
  end

  def create
    @product = Product.new(product_params)
    pattern_names = params[:product][:pattern_names] # Fetch selected pattern names from params

    if @product.save
      # Associate each selected pattern with the newly created product
      pattern_names.each do |pattern_name|
        selected_pattern = ProductPattern.find_by(pattern_name:)
        @product.product_patterns.create(pattern_name:) if selected_pattern
      end

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
    Rails.logger.debug "Search Param: #{params[:search]}"
    Rails.logger.debug "Pattern Param: #{params[:pattern]}"
    @products = Product.includes(:product_patterns)

    @products = @products.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?

    @products = @products.where(product_patterns: { pattern_name: params[:pattern] }) if params[:pattern].present?

    @products = @products.page(params[:page]).per(10)

    render "home/index"
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :outdoor, :on_sale, :description, :pattern)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
