class SingleOrdersController < ApplicationController

  # создание одиночного заказа
  def index
  	@single_orders = Order.all.order('created_at ASC')
  	set_line_items
    respond_to do |format|
      format.html
      format.csv { send_data @line_item.to_csv}
    end
  end

  # просмотр одиночного заказа
  def show
  	@single_order = Order.find(params[:id])
  	@line_items = LineItem.where(order_id: @single_order.id)
  end

  def destroy
  end


  private

  # устанавливаем записи соединительной таблицы
  def set_line_items
    @mass = []
  	@single_orders.each do |order|
      @mass << order.id
    end
  	@line_item = LineItem.where(order_id: @mass)
    @mass = nil
  end
end
