class PurchaserAddress
  #ヘルパーメソッドの引数として扱え、バリデーションの機能を使用できるようにするコード
  include ActiveModel::Model
  #purchasersテーブルとaddressesテーブルに保存したいカラム名を、すべて指定またtokenの値も取り扱えるようにした
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  #purchasersモデルとaddressesモデルのバリデーションを記述
  with_options presence: true do
    #アソシエーションが組めないためバリデーションを記載
    validates :token
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with:/\A\d{3}[-]\d{4}\z/, message: 'はハイフンを入れ入力して下さい'}
    validates :prefecture_id, numericality: { other_than: 1, message: 'は、--以外を選択して下さい' }
    validates :city
    validates :house_number
    validates :phone_number, format: { with:/\A\d{1,11}\z/, message: 'は10桁または11桁の値を入力して下さい'}
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