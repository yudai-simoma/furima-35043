FactoryBot.define do
  factory :item do
      product { 'テスト' }
      product_description{ 'テスト中' }
      category { 2 }
      status { 2 }
      ship_base { 2 }
      prefecture { 2 }
      ship_date { 2 }
      price { 1000 }

      #生成するダミーデータに画像を添付
      after(:build) do |item|
        item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
      end
  end
end
