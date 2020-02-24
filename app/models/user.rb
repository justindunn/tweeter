class User < ApplicationRecord
  has_many :tweets
  validates :twitter_handle, presence: true
  validates :name, presence: true
  validates :email, presence: true
end
