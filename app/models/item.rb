class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :area
  belongs_to :deadline
  has_one_attached :image

  validates :title, :description, :category_id, :condition_id, :postage_id, :area_id, :deadline, :price, :image, presence: true

  with_options presence: true, format: { with: /\A([3-9]\d{2}|[1-9]\d{3,6}|[1-9]\d{0,2}(,\d{3}){1,2})\z/, message: 'には¥300~¥9,999,999の半角数字を使用してください' } do
    validates :price, presence: true
  end

  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :postage_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :area_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :deadline_id, numericality: { other_than: 1 , message: "can't be blank"}

end