class Admin::HomesController < ApplicationController
  def top
    @customer = params[:customer_id]
    if @customer
      @orders = Order.where(customer_id: @customer)
    else
      @orders = Order.all
    end
  end
end
