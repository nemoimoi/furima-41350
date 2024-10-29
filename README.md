# README

## usersテーブル
|Column          |Type      |Options          |
|----------------|----------|-----------------|
|nickname        |string    |null: false      |
|email           |string    |null: false,unique: true|
|password        |string    |null: false      |
|last_name       |string    |null: false      |
|first_name      |string    |null: false      |
|last_name_kana  |string    |null: false      |
|first_name_kana |string    |null: false      |
|birth_yyyy      |integer   |null: false      |
|birth_mm        |integer   |null: false      |
|birth_dd        |integer   |null: false      |

### Association
- has_many :items
- has_many :payments

## itemsテーブル
|Column          |Type      |Options          |
|----------------|----------|-----------------|
|title           |string    |null: false      |
|description     |text      |null: false      |
|content         |text      |null: false      |
|about_shipping  |string    |null: false      |
|price           |integer   |null: false      |
|user            |references|null: false,foreign_key: true|
※imageはActive Storageを使用予定

### Association
- belongs_to :user
- has_one :shipping_information

## paymentsテーブル
|Column          |Type      |Options          |
|----------------|----------|-----------------|
|buy             |string    |null: false	    |
|user            |references|bull: false,foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_information

## shipping_informationテーブル
|Column          |Type      |Options          |
|----------------|----------|-----------------|
|postcode        |integer   |null: false	    |
|prefecture      |string    |null: false	    |
|municipality    |string    |null: false	    |
|house_number    |string    |null: false	    |
|building_name   |string    |null: false	    |
|telephone_number|integer   |null: false	    |
|user            |references|null: false,foreign_key: true|

### Association
- belongs_to :payment
