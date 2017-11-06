class Member < ApplicationRecord
  # описываем взаимосвязи
  belongs_to :group
  belongs_to :user
end
