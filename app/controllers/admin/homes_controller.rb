class Admin::HomesController < ApplicationController
   before_action :authenticate_admin_admin!
  
  def top
    @customer = params[:customer_id]
    if @customer
      @orders = Order.where(customer_id: @customer)
    else
      @orders = Order.all
    end
  end
end
