# テーブル設計

## users テーブル

| Column              | Type   | Options                   |
| ------------------- | ------ | ------------------------- |
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| last_name           | string | null: false               |
| first_name          | string | null: false               |
| last_name_katakana  | string | null: false               |
| first_name_katakana | string | null: false               |
| birthdate           | date   | null: false               |

### Association

- has_many :items
- has_many :purchase


## items テーブル

| Column            | Type    | Options     |
| ----------------- | ------- | ----------- |
| item_name         | string  | null: false |
| item_detail       | string  | null: false |
| item_condition_id | integer | null: false |
| fee_burdened_id   | integer | null: false |
| prefecture_id     | integer | null: false |
| shipping_date_id  | integer | null: false |
| category          | string  | null: false |
| price             | string  | null: false |

### Association

- belongs_to :user
- has_one :purchase


## purchase テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address


## address テーブル

| Column         | Type    | Options                        |
| -------------- | ------- | ------------------------------ |
| purchase_id    | string  | null: false, foreign_key: true |
| post_code      | string  | null: false                    |
| prefecture_id  | integer | null: false                    |
| city           | string  | null: false                    |
| address_number | string  | null: false                    |
| building       | string  |                                |
| phone_number   | string  | null: false                    |

### Association

- belongs_to :purchase