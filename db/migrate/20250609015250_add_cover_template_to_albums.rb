class AddCoverTemplateToAlbums < ActiveRecord::Migration[7.2]
  def change
    add_column :albums, :cover_template, :string, null: false, default: 'default_value'
  end
end
