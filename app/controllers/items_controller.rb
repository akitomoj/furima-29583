class ItemsController < ApplicationController
  def index
    @item = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    # @item_id = Purchase.find_by(item_id: params[:item_id])
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :detail, :category_id, :condition_id, :fee_burdened_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end
end
