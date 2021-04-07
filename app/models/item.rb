class Item < ApplicationRecord
  # 以下、それぞれの値が空では登録出来ないと言うバリデーションを持たせた
  with_options presence: true do
    validates :images
    validates :product
    validates :product_description
    # id: 1以外の数値であればデータベースに保存を許可
    with_options numericality: { other_than: 1, message: 'は、--以外を選択して下さい' } do
      validates :category_id
      validates :status_id
      validates :ship_base_id
      validates :prefecture_id
      validates :ship_date_id
    end
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'は、300円から9,999,999円までで入力して下さい' }
  end

  # アソシエーションを追加
  belongs_to :user
  has_one  :purchaser
  # 画像ファイルの紐付け
  has_many_attached :images
  # ActiveHashのアソシエーションを設定
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :ship_base
  belongs_to :prefecture
  belongs_to :ship_date
end
