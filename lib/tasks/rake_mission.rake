require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

task :hello do 
  puts 'Hello world'	
end

task :get_menu do
  product = Product.all
  product.each do |product|
  	puts "ID: #{product.id}"
  	puts "Тип меню: #{product.product_type.title}"
  	puts "Название блюда: #{product.title}"
  	puts "Описание: #{product.description}"
  	puts "Цена: #{product.price}"
  end
end
