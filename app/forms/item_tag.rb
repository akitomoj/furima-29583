class ItemTag

  include ActiveModel::Model
  attr_accessor :image, :name, :detail, :condition_id, :fee_burdened_id, :prefecture_id, :shipping_date_id, :category_id, :price, :tag_name, :user_id


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

  validates :price, presence: true, numericality: { greater_than: 299, less_than: 10_000_000 }


  def save
    item = Item.create(image: image, name: name, detail: detail, condition_id: condition_id, fee_burdened_id: fee_burdened_id, prefecture_id: prefecture_id, shipping_date_id: shipping_date_id, category_id: category_id, price: price, user_id: user_id)
    Tag.create(tag_name: tag_name, item_id: item.id)
  end

  def itemtag_find
    Item.find(params[:id])
    Tag.where(item_id: params[:id])
  end

end