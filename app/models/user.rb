class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :photoposts, dependent: :destroy
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
    Photopost.where("user_id = ?", id)
  end
end


