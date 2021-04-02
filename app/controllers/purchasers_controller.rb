class PurchasersController < ApplicationController
#ログイン状態によって表示するページを切り替えるコードでログインしていなければ、ログイン画面に遷移さる。
before_action :authenticate_user!, except: :index
 
  #商品購入ページを表示
  def index
    #itenモデルの情報を代入、paramsは「:id」ではなく「:item_id」とする
    @item = Item.find(params[:item_id])
    # form_withのmodelオプションで指定することができるコード
    @purchaser_address = PurchaserAddress.new
  end

  #商品購入の保存
  def create
    @item = Item.find(params[:item_id])
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
    Payjp.api_key = "sk_test_3e6d48bad5c1ca58c74ea109"  # 自身のPAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchaser_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
  
end