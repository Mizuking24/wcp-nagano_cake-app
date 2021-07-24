class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    order = order_detail.order
    order_details = order.order_details
    
    produce_count = 0
    done_count = 0
    order_details.each do |order_detail|
      if order_detail.create_status == "製作中"
        produce_count += 1
      end
      if order_detail.create_status == "製作完了"
        done_count +=1
      end
    end

    if produce_count >= 1
      order.update(order_status: "製作中")
    end
    if done_count == order_details.count
      order.update(order_status: "発送準備中")
    end


    # order_detail.change_order_status #change_order_statusはorder_detailモデルに定義
    redirect_to admin_path
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:create_status)
  end
end
