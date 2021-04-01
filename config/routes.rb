Rails.application.routes.draw do
  #新規登録のdevise呼ぶ時のコード
  devise_for :users
  #トップページを表示させるコード
  root to: 'items#index'
  #商品出品機能に必要な7つのアクション全て
  resources :items
end
