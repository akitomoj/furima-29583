class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase = ItemPurchase.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase = ItemPurchase.new(purchase_params)
    if @purchase.valid?

      @purchase.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private
  def purchase_params
    params.require(:item_purchase).permit(:post_code, :prefecture_id, :city, :address_number, :building, :phone_number, :number, :exp_month, :exp_year, :cvc).merge(item_id: params[:item_id], user_id: current_user.id)
  end
end
# require(:item_purchase).