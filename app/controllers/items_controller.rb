class ItemsController < ApplicationController
  #ログイン状態によって表示するページを切り替えるコードでログインしていなければ、ログイン画面に遷移さる。
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  #各アクションで使用しているコードを１つにまとめる
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  #ログインしていて、出品したユーザーとログインユーザーが違かったら編集ページに行けないように制限している
  before_action :move_to_index, only: [:edit, :update, :destroy]
  #購入済みの商品編集ページへいけないようにする
  before_action :move_to_root, only: [:edit, :update]


  # トップページを表示
  def index
    # 商品の情報を代入かつ新しい順に表示
    @items = Item.all.order('product DESC')
  end

  # 商品出品ページを表示
  def new
    @item = Item.new
  end

  # 商品出品の保存、保存されればトップページ、保存出来なければ商品出品ページ
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render new_item_path
    end
  end

  # 商品詳細ページを表示
  def show
    #before_actionで呼び出している
  end

  #編集ページを表示
  def edit
    #before_actionで呼び出している
  end

  #出品情報が更新されたら、保存される
  def update
    #before_actionで呼び出している
      if @item.update(item_params)
        redirect_to root_path
      else
        render :edit             
      end
  end

  #出品した商品を削除する
  def destroy
    if @item.destroy
      redirect_to root_path
    end
  end

private

  #imteモデルの情報から所得する制限をかけた
  def item_params
    params.require(:item).permit(:product, :product_description, :category_id, :status_id, :ship_base_id, :prefecture_id,
                                :ship_date_id, :price, :image).merge(user_id: current_user.id)
  end

  #before_actionで同じコードをまとめた
  def set_item
    @item = Item.find(params[:id])
  end
  
  #編集ページにアクセスする際、投稿したユーザーでないとアクセスできないように条件分岐している
  def move_to_index
    unless current_user.id == @item.user_id
      redirect_to action: :index
    end
  end

  #購入済みの商品編集ページへはいけないようにする
  def move_to_root
    #@itemの定義は、editアクションで定義済み
    if @item.purchaser.present?
      redirect_to root_path
    end
  end
end