class Item < ApplicationRecord
  #アソシエーションを追加
  belongs_to :user
end
