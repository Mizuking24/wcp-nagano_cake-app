class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum create_status: {"着手不可": 0, "製作待ち": 1, "製作中": 2, "製作完了": 3}
  
  def change_order_status
    products = self.order.ordered_products
    if self.create_status == "製作中" #ひとつでも制作ステータスが製作中なら注文ステータスも制作中になる
      self.order.update(order_status: "製作中")
    elsif products.pluck(:create_status).all?{ |status| status == "製作完了"} #全ての商品の制作ステータスが制作完了になると注文ステータスが発送準備中になる
      self.order.update(order_status: "発送準備中")
    end
  end
end
