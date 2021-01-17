class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :fee_burdened
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_date

  belongs_to :user
  has_one :purchase
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :name,    length: { maximum: 40 }
    validates :detail,  length: { maximum: 1000 }
  end

  with_options numericality: { other_than: 1 } do
    validates :condition_id
    validates :fee_burdened_id
    validates :prefecture_id
    validates :shipping_date_id
    validates :category_id
  end

  validates :price,             presence: true, numericality: { greater_than: 299, less_than: 10000000 }
end
