module Api
  module V1
    class OrdersController < ApplicationController
      def create
        return unless check_shipping_info(current_user)

        @user = User.find(order_params[:user_id])
        @province = Province.find(@user.province_id)
        @order = Order.new(
          user_id:        order_params[:user_id],
          base_cost:      order_params[:base_cost],
          total_cost:     order_params[:total_cost],
          order_status:   "New",
          payment_method: "Credit Card"
        )

        return unless @order.save

        Rails.logger.debug @order.inspect
        Order.transaction do
          session[:cart].map do |product_id, quantity|
            product = Product.find(product_id)
            order_product = OrderProduct.new(
              order:      @order,
              product:,
              amount:     quantity,
              base_cost:  product.price,
              gst:        @province.gst,
              pst:        @province.pst,
              hst:        @province.hst,
              total_cost: product.price * (@province.pst.to_f + @province.gst.to_f + @province.hst.to_f + 1)
            )
            order_product.save
          end
          session[:cart] = {}
        end
      end

      def checkout
        @user = User.find(current_user.id)
        Rails.logger.debug(current_user.inspect)
        @province = Province.find(current_user.province_id)

        @cart_products = session[:cart].map do |product_id, quantity|
          product = Product.find(product_id)
          { product:, quantity: }
        end

        @subtotal = calculate_subtotal(@cart_products)
        @total = calculate_total(@subtotal, @province.gst,
                                 @province.pst, @province.hst)
        session[:order_total] = @total

        render "checkout/show"
      end

      def calculate_subtotal(cart_products)
        cart_products.sum { |item| item[:product].price * item[:quantity] }
      end

      def calculate_total(subtotal, pst, gst, hst)
        subtotal * (pst.to_f + gst.to_f + hst.to_f + 1)
      end

      def check_shipping_info(user)
        return true unless user.postal_code.blank? || current_user.address.blank? || current_user.province_id.blank?

        flash[:alert] = "Please provide shipping address information to confirm the order."
        redirect_to checkout_checkout_path
        false
      end

      def order_params
        params.permit(:user_id, :base_cost, :total_cost, :credit_card_number, :credit_card_exp,
                      :credit_card_cvv, :authenticity_token, :commit)
      end
    end
  end
end
