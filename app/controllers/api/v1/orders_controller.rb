module Api
  module V1
    class OrdersController < ApplicationController
      def create
        return unless check_shipping_info(current_user)

        current_user.province

        @order = Order.new(order_params.merge(amount_cents:   rand(1000..10_000),
                                              payment_method: "credit_card"))
        if @order.save
          render json: { order: @order, payment: @order.payment }, status: :created
        else
          render json: @response.errors, status: :unprocessable_entity
        end
      end

      def checkout
        @user = User.find(current_user.id)
        @cart_products = session[:cart].map do |product_id, quantity|
          product = Product.find(product_id)
          { product:, quantity: }
        end

        @province = current_user.province
        Rails.logger.debug(@province)
        @subtotal = calculate_subtotal(@cart_products)
        @total = calculate_total(@subtotal, @province.gst,
                                 @province.pst, @province.hst)
        session[:order_total] = @total

        render "checkout/checkout"
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
        return true unless user.postal_code.blank? || current_user.address.blank? || province.blank?

        flash[:alert] = "Please provide shipping address information to confirm the order."
        redirect_to checkout_checkout_path
        false
      end

      def order_params
        params.require(:data).permit(:user_id, :base_cost, :credit_card_number, :credit_card_exp_month,
                                     :credit_card_exp_year, :credit_card_cvv)
      end
    end
  end
end
