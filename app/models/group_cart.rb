class GroupCart < ApplicationRecord
  belongs_to :group
  has_many :group_line_items, dependent: :destroy

  # метод добавления блюда в корзину
  # если блюдо уже есть в корзине то увеличить его кол-во на 1 
  # без добавления новой строки записи
  def add_product(product_id)
  	current_item = group_line_items.find_by(product_id: product_id)
  	if current_item
  	  current_item.quantity += 1
  	else
  	  current_item = group_line_items.build(product_id: product_id)
  	end
  	current_item
  end
end