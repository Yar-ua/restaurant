class LineItem < ApplicationRecord
  # описываем взаимосвязи
  belongs_to :product
  belongs_to :cart
  #belongs_to :order

  # подсчет стоимости всех позиций
  def total_price
  	product.price * quantity
  end

  # валидации количества
  validates :quantity, presence: {message: "введите количество!"}
  validates :quantity, numericality: { greater_than: 0.1, message: 'Значение стоимости должно быть целым числом, и больше ноля' }
  validates :quantity, numericality:  {only_integer: true}


  # формирование заказов по заказчикам в формате csv
  def self.to_csv(options = {})
    desired_columns = ["order", "user", "product", "quantity"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |line_item|
        order = Order.find(line_item.order_id)
        csv << [order.id, order.name, line_item.product.title, line_item.quantity]
      end
    end
  end


end

