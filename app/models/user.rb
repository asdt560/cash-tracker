class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :categories, dependent: :destroy, foreign_key: 'user_id'
  has_many :payments, dependent: :destroy, foreign_key: 'author_id'
  validates :name, presence: true
end