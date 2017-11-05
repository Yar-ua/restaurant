class LineItemsController < ApplicationController
  # LineItems - это соединительная таблица между продуктом и корзиной
  # подключаем созданный модуль по обнаружению корзины
  include CurrentCart
  # установить корзину перед записью туда блюда
  before_action :set_cart, only: [:index, :create, :edit, :update]

  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # выбрать все элеиенты соединительной таблицы
  def index
    @line_items = LineItem.all
    
  end


  def show
  end

  # создание нового элементы
  def new
    @line_item = LineItem.new
  end

  def edit
  end

  
  # создание нового элемента соед. таблицы
  def create
    product = Product.find(params[:product_id])
    # метод корзины add_product описан в модели корзины Cart
    @line_item = @cart.add_product(product.id)
    update_cart
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: 'Блюдо добавлено в предзаказ (корзину)' }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # обновление количества в соединительной таблице
  def update
    respond_to do |format|
      if @line_item.update(line_item_quantity_params)
        format.html { redirect_to @line_item.cart, notice: 'Количество обновлено' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # удалить элемент из соединительной таблицы
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to @line_item.cart, notice: 'Блюдо удалено из заказа' }
      format.json { head :no_content }
    end
  end

  private
    # установить элемент 
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # получаем параметры из формы по белому списку разрешенных параметров
    def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id)
    end

    # получить количество товара
    def line_item_quantity_params
      params.require(:line_item).permit(:quantity)
    end
end
