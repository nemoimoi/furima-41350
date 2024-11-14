class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :title,           null:false
      t.text       :description, null:false
      t.integer    :category_id, null:false
      t.integer    :condition_id,null:false
      t.integer    :area_id,     null:false
      t.integer    :deadline_id, null:false
      t.integer    :price,       null:false
      t.references :user,        null:false,foregign_key: true
      t.timestamps
    end
  end
end
