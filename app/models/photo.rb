class Photo < ApplicationRecord
  validates :comment, length: { maximum: 65_535 }
  belongs_to :user
  belongs_to :album
  mount_uploaders :images, ImageUploader
end
