class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item
  before_action :correct_purchase

  def index
    @purchase = ItemPurchase.new
  end

  def create
    @purchase = ItemPurchase.new(purchase_params)
    if @purchase.valid?
      pay_item
      @purchase.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private
  def purchase_params
    params.require(:item_purchase).permit(:post_code, :prefecture_id, :city, :address_number, :building, :phone_number, :number, :exp_month, :exp_year, :cvc).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def correct_purchase
    if user_signed_in? && (current_user.id == @item.user_id) || @item.purchase.present?
      redirect_to root_path
    end
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchase_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
