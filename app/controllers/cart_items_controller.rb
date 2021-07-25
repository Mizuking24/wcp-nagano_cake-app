class CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    # @total = 0
    # @cart_items.each do |cart_item|
    #   tal = (cart_item.item.price * cart_item.amount * 1.1).round
    #   @total += tal
    # end
    @total = @cart_items.sum{|cart_item|(cart_item.item.price * cart_item.amount * 1.1).round}
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
     if @cart_item.save
       redirect_to  cart_items_path
     else
       flash[:notice] = "個数を選択してください"
       @item = @cart_item.item
       @cart_item = CartItem.new
       render "items/show"
     end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
