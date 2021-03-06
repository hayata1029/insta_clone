class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :photoposts, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
         
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    
    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        name:     auth.info.name,
        password: Devise.friendrly_token[0, 20],
        image:    auth.info.image
        )
    end
    
    user
  end
  
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Photopost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
  
   # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end
  
  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  
  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      User.all
    end
  end
end


