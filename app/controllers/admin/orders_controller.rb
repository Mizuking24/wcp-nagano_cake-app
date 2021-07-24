class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.where(order_id: params[:id])
    @total = @order_detail.sum{|order_detail|order_detail.price * order_detail.amount}
    @billing_amount = @total + @order.delivery_charge
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    order.change_create_status #change_create_statusはorderモデルに定義
    redirect_to admin_path
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end
