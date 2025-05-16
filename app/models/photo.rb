class Photo < ApplicationRecord
  validates :text, length: { maximum: 65_535 }
  belongs_to :album
  mount_uploaders :images, ImageUploader
end
