class Photo < ApplicationRecord
  validates :comment, length: { maximum: 65_535 }
  belongs_to :user
  belongs_to :album
  mount_uploaders :images, ImageUploader

  require "digest"

  def self.generate_image_hash(uploaded_file)
    content = uploaded_file.read # ファイルの中身だけを読み込んでSHA256を生成
    uploaded_file.rewind # 読み終えた後に位置を先頭に戻す
    Digest::SHA256.hexdigest(content)
  end
end
