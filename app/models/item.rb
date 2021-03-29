class Item < ApplicationRecord
  #アソシエーションを追加
  belongs_to :user
  #画像ファイルの紐付け
  has_one_attached :image
end
