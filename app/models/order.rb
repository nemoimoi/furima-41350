class Order < ApplicationRecord
  attr_accessor :token
  belongs_to :user
  belongs_to :item
  has_one :destination

  accepts_nested_attributes_for :destination
end
