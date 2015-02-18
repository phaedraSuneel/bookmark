class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :bookmarks, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  validates :username,
    presence: true,
    uniqueness: {case_sensitive: false},
    format: {with: /\w+/}

  def to_param
    self.username
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id) ? true : false
  end

  def follow(other_user)
    relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    relationships.where(followed_id:  other_user.id).first.destroy
  end

end
