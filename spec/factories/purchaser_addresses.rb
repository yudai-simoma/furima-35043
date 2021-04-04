FactoryBot.define do
  factory :purchaser_address do
    postal_code { "123-4567" }
    prefecture_id { 2 }
    city { '新宿区' }
    house_number { '1丁目1-1' }
    building_name { 'ハイムふじ' }
    phone_number { '09012345678' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
