class PurchaserAddress
  #ヘルパーメソッドの引数として扱え、バリデーションの機能を使用できるようにするコード
  include ActiveModel::Model
  #purchasersテーブルとaddressesテーブルに保存したいカラム名を、すべて指定
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id

  #purchasersモデルとaddressesモデルのバリデーションを記述
  with_options presence: true do
    #アソシエーションが組めないためバリデーションを記載
    validates :user_id
    validates :item_id
    validates :purchaser_id
    validates :postal_code, format: { with:/\A\d{3}[-]\d{4}\z/, message: 'is invalid. Input correctly'}
    validates :prefecture_id
    validates :city
    validates :house_number
    validates :phone_number, format: { with:/\A\d{11}\z/, message: 'is invalid. Input only number'}
  end

  #フォームから送られてきたデータをテーブルに保存する処理
  def save
    # 購入者情報を保存し、変数purchaserに代入する
    purchaser = Purchaser.create(user_id: user_id, item_id: item_id)
    # 住所を保存する
    # purchaser_idには、変数purchaserのidと指定する
    AddressBook.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, purchaser_id: purchaser.id)
  end
end