class ItemsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def index
    @item = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit

  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :detail, :category_id, :condition_id, :fee_burdened_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def correct_user
    @item = Item.find(params[:id])
    unless user_signed_in?
      redirect_to new_user_session_path 
    end
    if user_signed_in? && (current_user.id != @item.user_id)
        redirect_to root_path 
    end
  end
  
end