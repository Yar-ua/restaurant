class GroupCart < ApplicationRecord
  # описываем связи
  has_one :group
  has_many :group_line_items, dependent: :destroy

  # метод добавления блюда в корзину
  # если блюдо уже есть в корзине то увеличить его кол-во на 1 
  # без добавления новой строки записи
  def add_product(product_id, user_id)
  	current_item = group_line_items.where(product_id: product_id, user_id: user_id).take
  	if current_item
  	  current_item.quantity += 1
  	else
  	  current_item = group_line_items.build(product_id: product_id, user_id: user_id)
  	end
  	current_item
  end

  # подсчет суммы стоимости всех позиций
  def total_price
    group_line_items.to_a.sum { |item| item.total_price }
  end
  
end
