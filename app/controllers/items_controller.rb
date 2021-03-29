class ItemsController < ApplicationController
  
  #トップページを表示
  def index
  end

  #商品出品ページを表示
  def new
    @item = Item.new
  end

  #商品出品の保存、保存されればトップページ、保存出来なければ商品出品ページ
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render new_item_path
    end
  end
end

private

  def item_params
    params.require(:item).permit(:product, :product_description, :category_id, :status_id, :ship_base_id, :prefecture_id, :ship_date_id, :price,:image).merge(user_id: current_user.id)
  end