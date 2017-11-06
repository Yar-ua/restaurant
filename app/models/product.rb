class Product < ApplicationRecord
  # создание связи один ко многим - следовать за product_type
  belongs_to :product_type
  # имеет много записей связывающей таблицы
  has_many :line_items
  has_many :group_line_items
  has_many :line_items

  # определяем методы валидации продукта
  validates :title, presence: { message: 'Название не может быть пустым' }
  validates :title, length: { maximum: 30, message: 'Название не может быть длиннее 30 символов' }
  validates :description, length: { maximum: 255, message: 'Описание блюда должно быть не длиннее 255 символов' }
  validates :price, numericality: { greater_than: 0, message: 'Значение стоимости должно быть числом, и больше ноля' }

  # перед удалением проверяем отсутствие товара в соед. таблице
  before_destroy :ensure_not_references_by_any_line_item
  before_destroy :ensure_not_references_by_any_group_line_item

  private

  # убеждаемся в отсутствии позиций данного блюда в соединительной таблице заказов
  # чтобы не удалить блюдо из меню, в то время когда его заказали
  def ensure_not_references_by_any_line_item
  	if line_items.empty?
  	  return true
  	else
  	  errors.add(:base, 'существуют такие позиции блюд')
  	  return false
  	end
  end

  # убеждаемся в отсутствии позиций данного блюда в соединительной таблице групповых заказов
  # чтобы не удалить блюдо из меню, в то время когда его заказали
  def ensure_not_references_by_any_group_line_item
    if group_line_items.empty?
      return true
    else
      errors.add(:base, 'существуют такие позиции блюд')
      return false
    end
  end

  # оормирование ответа по составу меню в формате csv
  def self.to_csv(options = {})
    desired_columns = ["id", "title", "description", "price", "product_type"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |product|
        csv << [product.id, product.title, product.description, product.price, product.product_type.title]
      end
    end
  end

end
