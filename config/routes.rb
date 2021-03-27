Rails.application.routes.draw do
  devise_for :users
  #トップページを表示させるコード
  root to: 'items#index'
end
