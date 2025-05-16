class CreatePhotos < ActiveRecord::Migration[7.2]
  def change
    create_table :photos do |t|
      t.json :images
      t.text :comment
      t.references :album, foreign_key: true
      t.timestamps
    end
  end
end
