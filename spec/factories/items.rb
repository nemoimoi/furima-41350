FactoryBot.define do
  factory :item do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    category_id { Category.where.not(id: 1).sample.id }
    condition_id { Condition.where.not(id: 1).sample.id }
    postage_id { Postage.where.not(id: 1).sample.id }
    area_id { Area.where.not(id: 1).sample.id }
    deadline_id { Deadline.where.not(id: 1).sample.id }
    price { Faker::Commerce.price(range: 300..9999999) }
    association :user
  
    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('public', 'shimaenaga_oen.png')), filename: 'shimaenaga_oen.png',content_type: 'image/png')
    end
  end
end
