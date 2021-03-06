class Photopost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true
  has_many :iine_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  
  # 投稿した画像にいいねをする
  def iine(user)
    likes.create(user_id: user.id)
  end
  
  # 投稿した画像のいいねを外す
  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end
  
  # 現在のユーザーが言い値してたらtrueを返す
  def iine?(user)
    iine_users.include?(user)
  end
  
  def self.search(search)
    if search
      where(['content LIKE ?', "%#{search}%"]) 
    else
      all 
    end
  end
end


