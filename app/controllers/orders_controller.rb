class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = current_customer
  end

  def info
    @order = Order.new
    if params[:order] [:payment_method] == "0"
      @order.payment_method = "クレジットカード"
    else
      @order.payment_method = "銀行振込"
    end

    if params[:order] [:address_option] == "0"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order] [:address_option] == "1"
      address = Address.find(params[:order] [:address_id])
      @order.address = address.address
      @order.postal_code = address.postal_code
      @order.name = address.name
    else
      @order.address = params[:order] [:postal_code]
      @order.postal_code = params[:order] [:address]
      @order.name = params[:order] [:name]
    end

    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = @cart_items.sum{|cart_item|cart_item.item.price * cart_item.amount * 1.1}
    @item = Item.where(params[:id])
    @order.delivery_charge = 800
    @billing_amount = @total + @order.delivery_charge

  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.delivery_charge = 800
    if @order.save
      @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        @order_detail = @order.order_details.new
        @order_detail.item_id = cart_item.item.id
        @order_detail.price = cart_item.item.price * 1.1
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end
      @cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @total = @cart_items.sum{|cart_item|cart_item.item.price * cart_item.amount * 1.1}
      @item = Item.where(params[:id])
      @billing_amount = @total + @order.delivery_charge
      render :info
      flash[:notice] = "値を入力してください。"
    end
  end

  def thanks
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
  end


  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :payment_method, :billing_amount)
  end
end
