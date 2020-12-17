# テーブル設計

## users テーブル

| Column   | Type   | Options                   |
| -------- | ------ | ------------------------- |
| nickname | string | null: false               |
| email    | string | null: false, unique: true |
| password | string | null: false               |

### Association

- has_many :items
- has_many :purchase


## items テーブル

| Column      | Type   | Options     |
| ----------- | ------ | ----------- |
| item_image  | string | null: false |
| item_name   | string | null: false |
| item_detail | string | null: false |

### Association

- belongs_to :users
- has_one :purchase


## purchase テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :items
- belongs_to :address


## address テーブル

| Column         | Type   | Options     |
| -------------- | ------ | ----------- |
| post_code      | string | null: false |
| prefecture     | string | null: false |
| city           | string | null: false |
| address_number | string | null: false |
| building       | string |             |
| phone_number   | string | null: false |

### Association

- belongs_to :purchase