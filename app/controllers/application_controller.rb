class ApplicationController < ActionController::Base
  # Basic認証の導入
  before_action :basic_auth
  # deviseのストロングパラメーターを使用出来るようにした
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  private

  # Basic認証の導入, username及びpasswordをそれぞれ環境変数に定義
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD'] # 環境変数を読み込む記述に変更
    end
  end

  # deviseのストロングパラメターを定義
  # メソッド名は慣習
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name_kana])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name_kana])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:birthday_date])
  end
end
