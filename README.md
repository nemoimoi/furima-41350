# README

## usersテーブル
|Column            |Type      |Options          |
|------------------|----------|-----------------|
|nickname          |string    |null: false      |
|email             |string    |null: false,unique: true|
|encrypted_password|string    |null: false      |
|last_name         |string    |null: false      |
|first_name        |string    |null: false      |
|last_name_kana    |string    |null: false      |
|first_name_kana   |string    |null: false      |
|birthday          |date      |null: false      |

### Association
- has_many :items
- has_many :orders

## itemsテーブル
|Column           |Type      |Options          |
|-----------------|----------|-----------------|
|title            |string    |null: false      |
|description      |text      |null: false      |
|category_id      |integer   |null: false      |
|condition_id     |integer   |null: false      |
|postage_id       |integer   |null: false      |
|area_id          |integer   |null: false      |
|deadline_id      |integer   |null:false       |
|price            |integer   |null: false      |
|user             |references|null: false,foreign_key: true|
※imageはActive Storageを使用予定

### Association
- belongs_to :user
- has_one :order

## ordersテーブル
|Column          |Type      |Options          |
|----------------|----------|-----------------|
|buy             |string    |null: false	    |
|user            |references|null: false,foreign_key: true|
|item            |references|null: false,foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- has_one :destination

## destinationsテーブル
|Column          |Type      |Options          |
|----------------|----------|-----------------|
|postcode        |string    |null: false	    |
|area_id         |integer   |null: false	    |
|municipality    |string    |null: false	    |
|house_number    |string    |null: false	    |
|building_name   |string    |           	    |
|telephone_number|string    |null: false	    |
|item            |references|null: false,foreign_key: true|

### Association
- belongs_to :order
