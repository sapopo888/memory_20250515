class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable # email再設定時の認証メール送信

  validates :name, presence: true, length: { maximum: 30 }
  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy
end
