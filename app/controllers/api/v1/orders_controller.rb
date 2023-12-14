class Api::V1::OrdersController < ApplicationController
  # Needs price calculation functions once home.
  def create
    order_status = "New"
    payment_method = "Credit Card"

    @order = Order.new(order_params.merge(amount_cents:   rand(1000..10_000),
                                          payment_method: "credit_card"))
    if @order.save
      render json: { order: @order, payment: @order.payment }, status: :created
    else
      render json: @response.errors, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:data).permit(:user_id, :base_cost, :credit_card_number, :credit_card_exp_month,
                                 :credit_card_exp_year, :credit_card_cvv)
  end
end
