class ProductTypesController < ApplicationController

  before_action :set_all_product_types, only: [:index, :show]
  before_action :set_product_type, only: [:show]
  
  def index
  	# @product_types = ProductType.all
  end

  def new
  	@product_type = ProductType.new
  end

  def create
  	@product_type = ProductType.new(product_type_params)
  	if @product_type.save
  	  redirect_to product_types_path, notice: 'Категория меню добавлена'
  	else
  	  render :new
  	end
  end

  def show

  end


  private

  def product_type_params
  	params.require(:product_type).permit(:title)
  end

  def set_all_product_types
    @product_types = ProductType.all
  end

  def set_product_type
    @product_type = ProductType.find(params[:id])
  end

end