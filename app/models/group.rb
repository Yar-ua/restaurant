class Group < ApplicationRecord
  # описываем связи
  belongs_to :user
  has_many :joiners, dependent: :destroy
  has_many :members, dependent: :destroy
  has_one :group_cart, dependent: :destroy
  #belongs_to :group_order

  # валидация длины имени
  validates :name, length: { in: 3...30, message: 'Название группы в пределах 3...30 символов' }
end
