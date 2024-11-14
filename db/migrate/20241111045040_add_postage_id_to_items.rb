class AddPostageIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :postage_id, :integer
  end
end
