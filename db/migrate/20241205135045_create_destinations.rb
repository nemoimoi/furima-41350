class CreateDestinations < ActiveRecord::Migration[7.0]
  def change
    create_table :destinations do |t|
      t.string            :postcode,          null:false
      t.integer           :area_id,           null:false
      t.string            :municipality,      null:false
      t.string            :house_number,      null:false
      t.string            :building_name,     null:false
      t.string            :telephone_number,  null:false
      t.references        :order,             null:false,foreign_key: true
      t.timestamps
    end
  end
end
