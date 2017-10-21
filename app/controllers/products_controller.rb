class ProductsController < ApplicationController
  before_action :set_product_type, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # выводим исключение если неверно указан id категории меню
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_product
  
  # для действий требуем аутентифицировать юзера
  before_action :authenticate_user!
  
  def index
    @products = Product.all
  end

  
  def new
    @new_product = @product_type.products.build
  end


  def create
    @new_product = @product_type.products.build(product_params)
    if @new_product.save
      redirect_to product_type_path(id: @product_type.id), notice: 'Блюдо добавлено в меню'
    else
      render 'new', alert: 'Что то пошло не так'
    end
  end


  def show

  end


  def edit

  end


  def update
   
    if @product.update(product_params)
      redirect_to product_type_path(id: @product.product_type_id), method: :patch, notice: 'Блюдо обновлено в меню'
    else
      render 'edit', alert: 'Что то пошло не так'
    end
  end


  def destroy
    @product.destroy
    redirect_to product_type_path(id: @product.product_type_id), notice: 'Блюдо удалено из меню'
  end


  private
  

    def set_product_type
      @product_type = ProductType.find(params[:product_type_id])
    end


    def set_product
      @product = @product_type.products.find(params[:id])    
    end


    def product_params
      params.require(:product).permit(:title, :description, :price)
    end

    # выдаем исключение при неправильно указанно блюдо
    def invalid_product
      logger.error "Неверно указано блюдо #{params[:id]}"
      redirect_to root_path, alert: 'Некорректно указано блюдо'
    end

end
