class Photopost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :picture, presence: true
  validates :content, presence: true
end


