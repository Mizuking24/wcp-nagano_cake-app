class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    order_detail.change_order_status #change_order_statusはorder_detailモデルに定義
    redirect_to admin_path
  end
  
  private
  def order_detail_params
    params.require(:order_detail).permit(:create_status)
  end
end
