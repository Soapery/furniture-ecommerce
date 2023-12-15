module Api
  module V1
    class OrdersController < ApplicationController
      def create
        return unless check_shipping_info(current_user)

        @order = Order.new(order_params.merge(
                             base_cost: @subtotal, total_cost: @total,
                             order_status: "New", payment_method: "Credit Card"
                           ))

        if @order.save
          @cart_products.each do |item|
            product = item[:product]
            quantity = item[:quantity]
            @order.order_products.create!(
              amount:     quantity,
              base_cost:  product.price,
              gst:        @province.gst,
              pst:        @province.pst,
              hst:        @province.hst,
              total_cost: product.price * (pst.to_f + gst.to_f + hst.to_f + 1),
              order_id:   @order.id,
              product_id: product.id
            )
          end

          render json: { order: @order, payment: @order.payment }, status: :created
        else
          render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
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

      def confirm_order
        return unless check_shipping_info(current_user)

        Order.create!(
          user_id: current_user.id,
          status:  "In Progress",
          total:   session[:order_total]
        )

        session[:cart].each_key do |product_id|
          Product.find(product_id)
        end

        session[:cart] = {}
        session[:order_total] = nil

        redirect_to order_confirmed_path, notice: "Order placed successfully!"
      end

      private

      def calculate_subtotal(cart_products)
        cart_products.sum { |item| item[:product].price * item[:quantity] }
      end

      def calculate_total(subtotal, pst, gst, hst)
        subtotal * (pst.to_f + gst.to_f + hst.to_f + 1)
      end

      def check_shipping_info(user)
        unless user.postal_code.blank? || current_user.address.blank? || current_user.province_id.blank?
          return true
        end

        flash[:alert] = "Please provide shipping address information to confirm the order."
        redirect_to checkout_checkout_path
        false
      end

      def order_params
        params.require(:order).permit(:credit_card_number, :credit_card_exp, :credit_card_cvv)
      end
    end
  end
end
