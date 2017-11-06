require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

# проверочная задача
task :hello do 
  puts 'Hello world'	
end

# задача на получение состава меню
task :get_menu do
  product = Product.all
  product.each do |product|
  	puts "ID: #{product.id}"
  	puts "Тип меню: #{product.product_type.title}"
  	puts "Название блюда: #{product.title}"
  	puts "Описание: #{product.description}"
  	puts "Цена: #{product.price}"
  	puts '------------'
  end
end


task :orders => :single_orders do
  #
end

# задача по получению одиночных заказов
task :single_orders =>  :group_orders do
  puts "---Одиночные заказы---"
  puts
  orders = Order.all
  orders.each do |order|
  	print "Заказ ID: #{order.id} | заказчик #{order.name} |оплата: #{order.pay_type} |"
    puts "комментарии к заказу: #{order.notice}"
    order.line_items.each do |item|
      puts "#{item.product.title} - #{item.quantity} шт"
    end
    puts "Итого: #{order.price} грн"
    puts
  end
end


task :group_orders do

  puts "---Групповые заказы---"
  puts
  group_orders = GroupOrder.all
  group_orders.each do |group_order|
  	puts "Заказ ID: #{group_order.id} | оплата: #{group_order.pay_type} | комментарии к заказу #{group_order.notice}"
 	group_order.group_line_items.each do |item|
 	  print "#{item.product.title} - #{item.quantity} | #{item.product.price * item.quantity} грн |"
      puts "заказал юзер #{item.user.name}"
    end
    puts "--------"
    puts "Итого: #{group_order.price} грн"
    puts
  end
end
