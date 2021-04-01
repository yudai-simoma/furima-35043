FactoryBot.define do
  factory :item do
    product { 'テスト' }
    product_description { 'テスト中' }
    category_id { 2 }
    status_id { 2 }
    ship_base_id { 2 }
    prefecture_id { 2 }
    ship_date_id { 2 }
    price { 1000 }
    # userとのアソシエーション
    association :user

    # 生成するダミーデータに画像を添付
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
