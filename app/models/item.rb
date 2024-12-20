class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :area
  belongs_to :deadline
  has_one :order
  has_one_attached :image

  attr_accessor :fake_price

  validates :title, :description, :category_id, :condition_id, :postage_id, :area_id, :deadline_id, :image, presence: true
  validates :price, numericality: { 
    only_integer: true,
    greater_than_or_equal_to: 300, 
    less_than_or_equal_to: 9_999_999
  }
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :postage_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :area_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :deadline_id, numericality: { other_than: 1, message: "can't be blank" }

  validate :price_must_be_valid

  before_validation :set_price_from_fake_price

  def sold_out?
    self.order.present?
  end

  private

  def price_must_be_valid
    return if fake_price.blank?

    if fake_price.present?
      if fake_price.is_a?(String) && !fake_price.match?(/\A[0-9]+\z/)
        errors.add(:price, "can't contain anything other than half-width numbers.")
      elsif fake_price.to_i < 300 || fake_price.to_i > 9_999_999
        errors.add(:price, "must be between 300 and 9_999_999")
      end
    end
  end

  def set_price_from_fake_price
    self.price = fake_price.to_i if fake_price.present? && fake_price.is_a?(String) && fake_price.match?(/\A[0-9]+\z/)
  end

end