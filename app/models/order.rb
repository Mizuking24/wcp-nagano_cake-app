class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: {"クレジットカード": 0, "銀行振込": 1}
  enum order_status: {"入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4}

  def change_create_status #注文ステータスが"入金確認"であれば製品ステータスを"製作待ち"にする
    if self.order_status == "入金確認"
      self.order_details.update(create_status: "製作待ち")
    end
  end
end
