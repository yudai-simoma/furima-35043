class Item < ApplicationRecord
  # 以下、それぞれの値が空では登録出来ないと言うバリデーションを持たせた
  with_options presence: true do
    validates :product
    validates :product_description
    validates :category_id
    validates :status_id
    validates :ship_base_id
    validates :prefecture_id
    validates :ship_date_id
    validates :price
    validates :image
  end

  #アソシエーションを追加
  belongs_to :user
  #画像ファイルの紐付け
  has_one_attached :image
end
