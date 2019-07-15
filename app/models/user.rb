class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :tweets, dependent: :destroy
  
  has_many :active_relationships,  class_name: "Relationship",
  								                 foreign_key: "follower_id",
  								                 dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes, dependent: :destroy
  
  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  
  # Follow another user
  def follow(other_user)
  	following << other_user
  end

  # Unfollow a user
  def unfollow(other_user)
  	following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
  	following.include?(other_user)
  end
end
