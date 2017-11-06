class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: { message: 'Имя не может быть пустым' }
  
  # описываем взаимосвязи
  has_one :cart
  has_many :groups, dependent: :destroy
  has_many :joiners, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :group_line_items, dependent: :destroy
  
end
