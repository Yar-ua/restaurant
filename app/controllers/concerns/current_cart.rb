module CurrentCart

  # пишем вспомогательный модуль по установке корзины 
  # для использования его в контроллере
  extended ActiveSupport::Concern

  private


  # устанавливаем текущую корзину юзера
  def set_cart
    if user_signed_in? == true
      if current_user.cart != nil
        @cart = current_user.cart
      else
        @cart = Cart.new
        @cart.user_id = current_user.id
        @cart.save
      end
    end
  end


  # устанавливаем метод обнаружения групповой корзины
  def set_group_cart
    if user_signed_in? == true
      if @group.group_cart != nil
        @group_cart = GroupCart.find(@group.group_cart.id)
      else 
        @group_cart = GroupCart.new
        @group_cart.group_id = @group.id
        @group_cart.save
      end
    end
  end


  # устанавливаем текущую группу
  def set_current_group
    @group = Group.find(params[:group_id])
  end


  # передаем данные о корзине через вебсокет
  def update_group_cart(group_line_items)
    ActionCable.server.broadcast("LineChannel", {
      title: 'Update Cart',
      # body: set_websocket_group_cart, # см. метод ниже
      table_line: set_websocket_table(group_line_items)   # см. метод ниже
      })
  end
  

  # получаем строку для передачи через вебсокет
  def set_websocket_group_cart
    return ('Моя групповая корзина ' + @group_cart.total_price.to_s +
       ' грн (' + @group_cart.group_line_items.count.to_s + ')').to_s
  end


  # устанавливаем таблицу в виде строки, передаваемую через вебсокет
  def set_websocket_table(group_line_items)
    response = ''
    @group_line_items.each do |group_line_item|
      response += ('<tr>
        <td>' + group_line_item.product.title.to_s + '</td>
        <td>' + group_line_item.product.description.to_s + '</td>
        <td>заказал клиент ' + group_line_item.user.name.to_s + '</td>
        <td>' + group_line_item.quantity.to_s + ' шт</td>
        <td>' + group_line_item.total_price.to_s + ' грн</td>' )
    end
    return response.to_s
  end


  # получаем строку для передачи через вебсокет
  def set_quantity_and_price
    @group_line_items = GroupLineItem.where(group_cart_id: @group_cart.id)
    @quantity = 0
    @price = 0
    @group_line_items.each do |item|
      @quantity += item.quantity
      @price += (item.quantity * item.product.price)
    end
  end
      

end