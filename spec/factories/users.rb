FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    #日本語の氏名を生成
    Faker::Config.locale = :ja
    last_name {Faker::Name.last_name}
    first_name {Faker::Name.first_name}

    last_name_kana {"テスト"}
    first_name_kana {"テスト"}
    birthday_date {'2000/12/12'}
  end
end