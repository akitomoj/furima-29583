class PurchasesController < ApplicationController
  before_action :find_item
  before_action :correct_purchase

  def index
    @purchase = ItemPurchase.new
  end

  def create
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

  def correct_purchase
    unless user_signed_in?
      redirect_to new_user_session_path 
    end
    if user_signed_in? && (current_user.id == @item.user_id)
      redirect_to root_path
    elsif Purchase.where(item_id: params[:item_id]).exists?
      redirect_to root_path
    end
  end

  def find_item
    @item = Item.find(params[:item_id])
  end
end
