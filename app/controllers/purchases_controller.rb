class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:id])
    @purchase = ItemPurchase.new
  end

  def create
    @purchase = ItemPurchase.new(purchase_params)
  end

  private
  def purchase_params
    params.require(:item_purchase).permit(:post_code, :prefecture_id, :city, :address_number, :building, :phone_number, :item_id, :user_id)
  end
end
