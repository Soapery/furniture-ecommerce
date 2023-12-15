class CartController < ApplicationController
  def add_to_cart
    product_id = params[:id]
    Product.find(product_id)

    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1

    redirect_to root_path, notice: "Added"
  end

  def update_product_quantity
    product_id = params[:id]
    quantity = params[:quantity].to_i
    session[:cart][product_id] = quantity if session[:cart].key?(product_id)
    redirect_to cart_path, notice: "Quantity updated"
  end

  def remove_product
    product_id = params[:id]
    session[:cart].delete(product_id) if session[:cart].key?(product_id)
    flash[:alert] = "Item removed from cart"
    redirect_to cart_path
  end

  def show; end
end
