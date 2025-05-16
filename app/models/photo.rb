class Photo < ApplicationRecord
  validates :text, length: { maximum: 65_535 }
  mount_uploaders :images, ImageUploader
end
