class User < ApplicationRecord
  has_many :meals, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :grocery_items, dependent: :destroy
  has_many :follows
  
  # active record doesn't allow “foreign_key” and “through” in the same macro, so we break it down into two.
  # “follower_relationships” is a virtual table. foreign_key tells it which column to look in, note: following_id is an ID of an instance in the User table. class_name tells it which table
  has_many :follower_relationships, foreign_key: "following_id", class_name: 'Follow', dependent: :destroy
  # has_many :followers is the method call that each instance of the User class will use to get its followers
  # source_key (follower) tells active record where to look when accessing “follower_relationships”, which is a custom version of the Follow model, so it looks at belongs_to follower in the Follow model
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: "follower_id", class_name: 'Follow', dependent: :destroy
  has_many :following, through: :following_relationships, source: :following

  devise :database_authenticatable, :validatable

  def name
    email.split("@").first.capitalize
  end

  def following?(user)
    following.include?(user)
  end
end
