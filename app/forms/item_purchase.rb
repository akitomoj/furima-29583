class ItemPurchase
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address_number, :building, :phone_number, :item_id, :user_id, :number, :exp_month, :exp_year, :cvc, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は無効です。ハイフン(-)を含めてください' }
    validates :prefecture_id, numericality: { other_than: 1, message: "を入れてください" }
    validates :address_number
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'は無効です。ハイフン(-)を含めてください' }
    validates :token, :city, :item_id, :user_id
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address_number: address_number, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end
