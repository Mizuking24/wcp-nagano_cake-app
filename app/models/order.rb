class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :customer_id, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :payment_method, presence: true
  validates :postal_code, presence: true, format: {with: /\A\d{7}\z/}

  enum payment_method: {"クレジットカード": 0, "銀行振込": 1}
  enum order_status: {"入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4}

  def change_create_status #注文ステータスが"入金確認"であれば製品ステータスを"製作待ち"にする
    if self.order_status == "入金確認"
      self.order_details.update(create_status: "製作待ち")
    end
  end
end
