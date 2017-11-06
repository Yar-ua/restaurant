class Order < ApplicationRecord
  # определяем массив видов оплаты
  PAYMENT_TYPES = ["наличными", "кредитной картой"]

  has_many :line_items, dependent: :destroy

  # определяем валидации
  validates :name, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  validates :notice, 
  			length: { maximum: 255, message: 'Комментари к заказу не должны быть длиннее 255 символов' }

  
  # метод установки аттрибутов заказа
  def set_order_attr(user)
  	self.name = user.name
  	self.email = user.email
  end

  # метод установки стоимости заказа
  def set_price(cart)
    item = LineItem.where(cart_id: cart.id)
    total = 0
    item.each do |i|
      total += (i.product.price * i.quantity)
    end
    self.price = total
  end

end
