class OrderDestination
  include ActiveModel::Model
  attr_accessor :postcode, :area_id, :municipality, :house_number, :building_name, :telephone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :area_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :token
    validates :municipality
    validates :house_number
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Include only numbers' }
    validates :item_id
    validates :user_id
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(postcode: postcode, area_id: area_id, municipality: municipality, house_number: house_number, building_name: building_name, telephone_number: telephone_number, order_id: order.id )
  end
end