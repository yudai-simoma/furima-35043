Rails.application.routes.draw do
  #新規登録のdevise呼ぶ時のコード
  devise_for :users
  #トップページを表示させるコード
  root to: 'items#index'
  #商品出品機能に必要な7つのアクション全て
  #商品購入に必要なアクションをネストしている
  resources :items do
    resources :purchasers, only: [:index, :create]
  end
end
