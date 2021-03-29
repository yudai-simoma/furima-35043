class Item < ApplicationRecord
  # 以下、それぞれの値が空では登録出来ないと言うバリデーションを持たせた
  with_options presence: true do
    validates :product
    validates :product_description
    #id: 1以外の数値であればデータベースに保存を許可
    with_options numericality: { other_than: 1 }do
    validates :category_id
    validates :status_id
    validates :ship_base_id
    validates :prefecture_id
    validates :ship_date_id
    end
    validates :price
    validates :image
  end

  #アソシエーションを追加
  belongs_to :user
  #画像ファイルの紐付け
  has_one_attached :image
  #ActiveHashのアソシエーションを設定
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :ship_base
  belongs_to :prefecture
  belongs_to :ship_date
end
