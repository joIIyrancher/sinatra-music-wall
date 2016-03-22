class User < ActiveRecord::Base
  has_many :songs
  has_many :likes

  validates :email, :password, presence: true
end
