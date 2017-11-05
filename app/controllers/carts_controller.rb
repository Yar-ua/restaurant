class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show, :edit, :destroy]
  # выдаем исключение если кто то пытается зайти в несуществующую корзину в строке браузера
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  after_action :update_cart, only: [:create, :edit]
  # устанавливаем все корзины
  def index
    @carts = Cart.all
  end


  def show
  end

  # создаем новый экземпляр корзины
  def new
    @cart = Cart.new
  end

  
  def edit
  end

  
  # создание корзины
  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      redirect_to @cart, notice: 'Cart was successfully created.'
    else
      render :new
    end
  end

  

  # очистка корзины заказов
  def destroy
    # удалить корзину если ее id совпадает с id юзера
    # чтобы не удалиласть корзина другого пользователя
    @cart.destroy if @cart.user_id == current_user.id
    session[:cart_id] = nil
    redirect_to root_path, notice: 'Ваша корзина заказа очищена'
  end

  private
    # устанавливаем текущую корзину
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # получаем пустышку параметров корзины
    def cart_params
      params.fetch(:cart, {})
    end

    # выдаем исключение при неправильно указанной корзине с блюдами
    def invalid_cart
      logger.error "Попытка доступа к несуществующей корзине заказа #{params[:id]}"
      redirect_to root_path, alert: 'Некорректно указано меню предзаказа'
    end
    
end
