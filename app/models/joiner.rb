class Joiner < ApplicationRecord
  # описываем взаимосвязи
  belongs_to :group
  belongs_to :user

  # описываем валидации
  validates :group_id, presence: true
  validates :user_id, presence: true
end
