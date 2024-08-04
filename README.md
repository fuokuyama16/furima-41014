# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name          | string | null: false, unique: true |
| family_name        | string | null: false |
| birth              | string | null: false |


### Association

- has_many :items
- has_many :orders


## items テーブル

| Column           | Type       | Options                        |
| ----------       | ---------- | ------------------------------ |
| image            | text       | null: false |
| name             | string     | null: false |
| description      | text       | null: false |
| category_id      | integer    | null: false |
| condition_id     | integer    | null: false |
| shipping_cost_id | integer    | null: false |
| prefecture_id    | integer    | null: false |
| shipping_days_id | integer    | null: false |
| price            | string     | null: false |
| user             | references | null: false, foreign_key: true |]

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user       | references | null: false, foreign_key: true |
| item       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column              | Type       | Options     |
| ------------------  | ---------- | ----------- |
| postal_code         | string     | null: false |
| prefecture_id       | integer    | null: false |
| city                | string     | null: false |
| street              | string     | null: false |
| building            | string     | 
| phone_number        | string     | null: false |
| order               | references | null: false, foreign_key: true |

### Association

- belongs_to :order