class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #以下、それぞれの値が空では登録出来ないと言うバリデーションを持たせた
  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birthday_date, presence: true
      
  #アソシエーションを記載
  has_many :items
  has_many :purchasers
  has_many :comments
end
