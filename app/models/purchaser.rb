class Purchaser < ApplicationRecord

  # アソシエーションを追加
  belongs_to :user
  belongs_to :item
  has_one    :address_book
  # ActiveHashのアソシエーションを設定
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
