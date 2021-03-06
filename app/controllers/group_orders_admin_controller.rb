class GroupOrdersAdminController < ApplicationController

  # выбор всех групповых заказов для просмотра в меню админа
  def index
  	@group_orders = GroupOrder.all.order("created_at ASC")
    @group_line_items = GroupLineItem.where(group_order_id: set_group_orders_ids).order(:group_order_id)
    # создаем вариант ответа в csv формате
    respond_to do |format|
      format.html
      format.csv { send_data @group_line_items.to_csv}
    end
  end

  # устанавливаем групповой заказ для просмотра
  def show
    @group_order = GroupOrder.find(params[:id])

    # если передан параметр 'by_user' то 
    # получаем коллекцию для просмотра и детализации по юзерам
    if params[:how_to_view] == 'by_user'
  	  @pull_users = set_pull_users(@group_order.group_line_items)

    # если передан параметр 'by_dish' то 
    # получаем коллекцию для просмотра и детализации блюдам
    elsif params[:how_to_view] == 'by_dish'
      @group_line_items = GroupLineItem.where(group_order_id: @group_order.id).group(:product_id)
      set_dish_collection
    end
  end

  def delete
  end

  private

  # устанавливаем список юзеров для группировки и просмотра заказа по заказчикам(юзерам)
  def set_pull_users(group_line_items)
  	pull_users = []
  	group_line_items.each do |item|
  	  pull_users << item.user
  	end
    pull_users.uniq
  end


  # устанавливаем коллекцию блюд для просмотра позиций заказанных товаров
  def set_dish_collection
    @group_dishes = []
    dish_hash = GroupLineItem.where(group_order_id: @group_order.id).group(:product_id).sum(:quantity)
    dish_hash.keys.each do |key|
      product = Product.find(key)
      quantity = dish_hash[key]
      @group_dishes << {product: product, quantity: quantity}
    end
  end

  # метод для экшена index - установка всех id заказов для выборки коллекции 
  # групповых товарных позиций для использования в партиалах
  def set_group_orders_ids
    GroupOrder.all.ids
  end

end
