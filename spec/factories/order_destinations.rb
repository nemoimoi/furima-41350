FactoryBot.define do
  factory :order_destination do
    postcode {'123-4567'}
    area_id {Area.where.not(id: 1).sample.id}
    municipality {'渋谷区'}
    house_number {'1番地'}
    building_name {'しまえながハウス'}
    telephone_number {'08012345678'}
    token {"tok_abcdefghijk00000000000000000"}
  end
end
