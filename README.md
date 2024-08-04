# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| name               | string | null: false |


### Association

- has_many :items
- has_many :orders
- has_many :addresses


## items テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| name       | string     | null: false |
| category   | string     | null: false |
| price      | string     | null: false |
| description| text       | null: false |
| user       | references | null: false, foreign_key: true |]

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
- belongs_to :address

## addresses テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| postal_code        | string     | null: false |
| prefecture         | string     | null: false |
| city               | string     | null: false |
| street             | string     | null: false |
| building           | string     | null: false |
| order              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :orders