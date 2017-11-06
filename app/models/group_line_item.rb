class GroupLineItem < ApplicationRecord
  # описываем взяимосвязи
  belongs_to :product
  belongs_to :group_cart
  belongs_to :user

  # подсчет стоимости всех позиций
  def total_price
  	product.price * quantity
  end

    
  # метод получения заказов в формате csv
  def self.to_csv(options = {})
    desired_columns = ["group_order_id", "user_id", "user_name", "product", "quantity"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |group_line_item|
        csv << [group_line_item.group_order_id, group_line_item.user_id, group_line_item.user.name,
        	group_line_item.product.title, group_line_item.quantity]
      end
    end
  end

end
