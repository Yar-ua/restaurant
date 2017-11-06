# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ProductType.find_or_create_by!(title: 'Первые блюда')
  Product.find_or_create_by!(title: 'Суп', description: 'из семи круп', price: 8, product_type_id: 1)
  Product.find_or_create_by!(title: 'Борщ', description: 'с буряком и сметаной', price: 10, product_type_id: 1)
  Product.find_or_create_by!(title: 'Уха', description: 'из карасей', price: 10, product_type_id: 1)
  Product.find_or_create_by!(title: 'Шурпа', description: 'с мясом', price: 12, product_type_id: 1)
ProductType.find_or_create_by!(title: 'Вторые блюда')
  Product.find_or_create_by!(title: 'Картошка', description: 'с мясом', price: 10, product_type_id: 2)
  Product.find_or_create_by!(title: 'Шашлык', description: 'из свинины', price: 16, product_type_id: 2)
  Product.find_or_create_by!(title: 'Гречка', description: 'с соусом', price: 6, product_type_id: 2)
ProductType.find_or_create_by!(title: 'Десерты')
  Product.find_or_create_by!(title: 'Яблочный пирог', description: 'в нем правда есть яблоки', price: 6, product_type_id: 3)
  Product.find_or_create_by!(title: 'Пирог с абрикосами', description: 'абрикосы с косточками', price: 5.75, product_type_id: 3)
ProductType.find_or_create_by!(title: 'Напитки')  
  Product.find_or_create_by!(title: 'Чай', description: 'в пакетиках', price: 4, product_type_id: 4)
  Product.find_or_create_by!(title: 'Кофе', description: 'Американо', price: 6.55, product_type_id: 4)
  Product.find_or_create_by!(title: 'Кофе', description: 'заварной', price: 10, product_type_id: 4)


User.find_or_create_by! email: 'admin@gmail.com' do |user|
  user.name = 'admin'
  user.email = 'admin@gmail.com'
  user.password = 'password'
  user.admin = true
end

