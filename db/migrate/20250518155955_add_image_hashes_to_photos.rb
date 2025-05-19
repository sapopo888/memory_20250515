class AddImageHashesToPhotos < ActiveRecord::Migration[7.2]
  def change
    add_column :photos, :image_hashes, :string, array: true, default: []
  end
end
