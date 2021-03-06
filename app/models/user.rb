class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 以下、それぞれの値が空では登録出来ないと言うバリデーションを持たせた
  with_options presence: true do
    validates :nickname
    # 以下、1字以上の全角ひらがな、全角カタカナ、漢字にマッチ
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'が不適切です。全角で入力して下さい' } do
      validates :last_name
      validates :first_name
    end
    # 以下、1字以上の全角カタカナにマッチ
    with_options format: { with: /\A[ァ-ヶー]+\z/, message: 'が不適切です。全角カタカナ文字で入力して下さい' } do
      validates :last_name_kana
      validates :first_name_kana
    end
    validates :birthday_date
    # 英数字混合出ないと登録できないバリデーション
    validates :password,
              format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は文字と数字の両方を含めて下さい' }
  end

  # アソシエーションを記載
  has_many :items
  has_many :purchasers
end
