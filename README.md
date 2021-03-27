# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| email           | string | null: false |
| password        | string | null: false |
| nickname        | string | null: false |
| last_name       | string | null: false |
| first_name      | string | null: false |
| last_name_kana  | string | null: false |
| first_name_kana | string | null: false |
| birthday_date   | date   | null: false |
| phone_number    | string |

### Association

- has_many :items
- has_one  :purchasers
- has_many :comments
- has_many :credit_cards
- has_many :address_books

## items テーブル

| Column              | Type       | Options     |
| ------------------- | ---------- | ----------- |
| image               | (ActiveStorageで実装) |
| product             | string型   | null: false |
| product_description | text型     | null: false |
| category_id         | integer    | null: false |
| status_id           | integer    | null: false |
| ship_base_id        | integer    | null: false |
| ship_region_id      | integer    | null: false |
| ship_date_id        | integer    | null: false |
| price               | integer    | null: false |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one  :purchasers
- has_many :comments

## purchasers テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false |
| prefecture_id | integer    | null: false |
| city          | string     | null: false |
| house_number  | string     | null: false |
| building_name | string     |
| phone_number  | string     | null: false |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |
| credit_catd   | references | foreign_key: true |
| addredd_book  | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :credit_catds
- has_one    :addredd_books

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| text    | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item


## credit_cards テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| card_number   | string     | null: false                    |
| expmonth      | integer    | null: false                    |
| expyear       | integer    | null: false                    |
| approval_code | string     | null: false                    |
| nominee       | string     | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :purchaser


## address_books テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :purchaser
