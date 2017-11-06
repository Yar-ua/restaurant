module ApplicationHelper

  # хелпер для иконок font-awesome
  def fa_icon
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  # проверка выполнен ли вход и является ли юзер админом
  def user_admin
  	if user_signed_in? and current_user.admin == true
  	  return true
  	end
  end

  # проверка того что пользователь выполнил вход и не является админом
  def user_login
  	if user_signed_in? and current_user.admin != true
  	  return true
  	end
  end
  
  # устанавливаем свое форматирование цены через метод I18n number_to_currency
  def my_number_to_currency(number)
    number_to_currency(number, :unit => "грн ", :separator => ".", :delimiter => " ")
  end


  # проверка что текущий юзер уже подал заявку в эту группу
  def current_user_already_send_join_to_group
    Joiner.where(user_id: current_user.id, group_id: @group.id).exists?
  end

  def current_user_already_in_this_group
    Member.where(user_id: current_user.id, group_id: @group.id).exists?
  end

end
