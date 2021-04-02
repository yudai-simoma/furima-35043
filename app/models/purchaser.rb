class Purchaser < ApplicationRecord

  # アソシエーションを追加
  belongs_to :user
  belongs_to :item
  has_one    :address_book

  # tokenの値をPurchaserモデルで取り扱えるようにしましょう
  attr_accessor :token
  
  # ActiveHashのアソシエーションを設定
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
