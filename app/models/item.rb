class Item < ApplicationRecord
  attachment :image

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :image, presence: true
  validates :price, presence: true
  validates :is_active, presence: true

end
