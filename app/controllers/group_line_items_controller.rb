class GroupLineItemsController < ApplicationController
  # подключаем модуль CurrentCart
  # устаанавливаем текущую группу и групповую корзину
  include CurrentCart
  before_action :set_current_group
  before_action :set_group_cart
  # before_action :set_group_line_items

  # устанавливаем текущую оварную позицию групповой корзины
  before_action :set_group_line_item, only: [:show, :edit, :update, :destroy]


  # извлекаем все товарные позиции
  def index
    @group_line_items = GroupLineItem.all
  end


  # создаем экземпляр групповой товарной позиции
  def new
    @group_line_item = GroupLineItem.new
  end


  def show
  end


  def edit
  end


  # создаем товарную позицию
  def create
    # ищем добавленный продукт
    product = Product.find(params[:product_id])
    # добавляем запись продукта и товарной позиции в корзине
    # см. метод group_carl.add_product в модели group_cart
    @group_line_item = @group_cart.add_product(product.id, current_user.id)
    # устанавливаем юзера для товарной позиции
    @group_line_item.user_id = current_user.id
    # сохраняем запись
    if @group_line_item.save
      # устанавливаем все линии текущей корзины
      set_group_line_items
      # обновляем даные заголовка корзины и посылаем их через вебсокет
      update_group_cart(@group_line_items)
      respond_to do |format|
        format.html {redirect_to group_cart_path(id: @group_cart.id), notice: 'Блюдо добавлено в предзаказ (корзину)'}
        format.js
      end
    end
  end


  # обновляем количество товаров в товарной позиции
  def update
    @group_line_item.update(group_line_item_quantity_params)
    # устанавливаем все линии текущей корзины
    set_group_line_items
    update_group_cart(@group_line_items)
    redirect_to group_cart_path(group_id: @group_line_item.group_cart.group_id, 
            id: @group_line_item.id), notice: 'Количество обновлено'
  end


  # удаляем запись товарной позиции
  def destroy
    if @group_line_item.destroy
      # устанавливаем все линии корзины и обновляем через вебсокет
      set_group_line_items
      update_group_cart(@group_line_items)
      respond_to do |f|
        f.html {redirect_to group_cart_path(id: @group_cart.id), notice: 'Блюдо удалено из заказа'}
        f.js
      end
    end
  end

  private

    # коллбек - установка текущей товарной позиции
    def set_group_line_item
      @group_line_item = GroupLineItem.find(params[:id])
    end

    # получение параметров товарной позиции из формы через "белый список" 
    def group_line_item_quantity_params
      params.require(:group_line_item).permit(:quantity)
    end

    def set_group_line_items
      @group_line_items = GroupLineItem.where(group_cart_id: @group_cart.id)
    end

end
