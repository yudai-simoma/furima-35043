# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| nickname           | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday_date      | date   | null: false |

### Association

- has_many :items
- has_many  :purchasers
- has_many :comments

## items テーブル

| Column              | Type       | Options     |
| ------------------- | ---------- | ----------- |
| product             | string     | null: false |
| product_description | text       | null: false |
| category_id         | integer    | null: false |
| status_id           | integer    | null: false |
| ship_base_id        | integer    | null: false |
| prefecture_id       | integer    | null: false |
| ship_date_id        | integer    | null: false |
| price               | integer    | null: false |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one  :purchaser
- has_many :comments

## purchasers テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :address_book

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| text    | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## address_books テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| purchaser     | references | null: false, foreign_key: true |

### Association

- belongs_to :purchaser
