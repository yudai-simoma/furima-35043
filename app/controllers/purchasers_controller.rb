class PurchasersController < ApplicationController
#ログイン状態によって表示するページを切り替えるコードでログインしていなければ、ログイン画面に遷移さる。
before_action :authenticate_user!, except: :index
 
  #商品購入ページを表示
  def index
  end

  #商品購入アクション
  def new
  end

  #商品購入の保存
  def create
    binding.pry
  end
end
