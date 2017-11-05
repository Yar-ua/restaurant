class StoreController < ApplicationController
  # установить корзину и все группы
  include CurrentCart
  before_action :set_cart

  before_action :set_all_groups
  
  def index
  	@product_types = ProductType.all
  	@products_all = Product.order(:title)
  end

  def show
    @product_type = ProductType.find(params[:id])
    @product_types = ProductType.all
    @products_by_product_type = @product_type.products.order('title ASC')
  end


  private

    # установить все группы
    def set_all_groups
      @all_groups = Group.all.order('name ASC')
    end

end
