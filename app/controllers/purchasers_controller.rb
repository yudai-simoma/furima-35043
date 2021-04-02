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
    @purchaser_address = PurchaserAddress.new(purchaser_params)
    #バリデーションを実行する機能がないため,バリデーションを持たせる
    if @purchaser_address.valid?
      @purchaser_address.save
      redirect_to root_path
    else
      #itenモデルの情報を代入、paramsは「:id」ではなく「:item_id」とする
      @item = Item.find(params[:item_id])
      render :index
    end
  end
end

  private

  def purchaser_params
    params.require(:purchaser_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
