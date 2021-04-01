class PurchasersController < ApplicationController
#ログイン状態によって表示するページを切り替えるコードでログインしていなければ、ログイン画面に遷移さる。
before_action :authenticate_user!, except: :index
 

  def index

  end

end
