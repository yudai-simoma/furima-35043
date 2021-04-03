class PurchasersController < ApplicationController
#ログイン状態によって表示するページを切り替えるコードでログインしていなければ、ログイン画面に遷移さる。
before_action :authenticate_user!, only: [:index, :create]
#各アクションで使用しているコードを１つにまとめる
before_action :set_item, only: [:index, :create, :redirect_root, :move_to_root]
#ログインしていて、自分の出品した商品ページへ遷移しようとするとトップページへ遷移する
before_action :redirect_root, only:[:index, :create]
#購入済みの商品購入ページへはいけないようにする
before_action :move_to_root, only: :index

  #商品購入ページを表示
  def index
    #itenモデルの情報を代入、paramsは「:id」ではなく「:item_id」とする
    #before_actionで呼び出している
    # form_withのmodelオプションで指定することができるコード
    @purchaser_address = PurchaserAddress.new
  end

  #商品購入の保存
  def create
    #before_actionで呼び出している
    @purchaser_address = PurchaserAddress.new(purchaser_params)
    #バリデーションを実行する機能がないため,バリデーションを持たせる
    if @purchaser_address.valid?
      pay_item
      @purchaser_address.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchaser_params
    params.require(:purchaser_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    # 決済処理を行っているコード
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵（環境変数に設定）
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchaser_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  #before_actionで同じコードをまとめた
  def set_item
    @item = Item.find(params[:item_id])
  end

  # ログインしていて、自分の出品した商品ページへ遷移しようとするとトップページへ遷移する
  def redirect_root
    #before_actionで呼び出している
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  #購入済みの商品購入ページへはいけないようにする
  def move_to_root
    #before_actionで呼び出している
    if @item.purchaser.present?
      redirect_to root_path
    end
  end
end