class GroupCartsController < ApplicationController
  # подключаем модуль CurrentCart с его методами по установке текущей групповой корзины
  # 
  include CurrentCart
  # устанавливаем текущую группу
  before_action :set_current_group #, except: [:destroy]
  # далее устанавливаем групповую корзину
  before_action :set_group_cart #, except: [:destroy]
  before_action :set_quantity_and_price
  after_action :update_cart, only: [:create, :edit]

  # выдаем исключение при запросе некорректной корзины
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  # удаление групповой корзины (очистка корзины)
  def destroy
    # очищаем все товарные позиции group_line_items
    @group_cart.group_line_items.destroy_all
    redirect_to group_path(id: @group_cart.group_id), notice: 'Групповая корзина очищена'
  end

  private


  # выдаем исключение при неправильно указанной корзине с блюдами
  def invalid_cart
    logger.error "Попытка доступа к несуществующей корзине заказа #{params[:id]}"
    redirect_to root_path, alert: 'Некорректно указано меню предзаказа'
  end
  
end
