class Order < ActiveRecord::Base
  has_many :line_items
  attr_accessible :name, :address, :email, :pay_type
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
 
  validates_presence_of :name, :address, :email, :pay_type
  validates :pay_type, :inclusion => PAYMENT_TYPES

 def add_line_items_from_cart(cart)
  cart.items.each do |item|
    li=LineItem.form_cart_item(item)
    line_items << li 
  end
 end
end
