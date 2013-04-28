class StoreController < ApplicationController
  def index
    @products = Product.find_products_for_sale
    @cart = find_cart
  end

  def show 
    @products = Product.find_products_for_sale
    @cart = find_cart
  end

  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @cart.add_product(product)
    respond_to do |format|
      format.js
      format.html{redirect_to_index}
    end
  rescue ActiveRecord::RecordNotFound
    logger.error("Not Valid Product#{params[:id]}")
    redirect_to_index("Not Vaild Product")
  end

  def find_cart
    session[:cart] ||= Cart.new
  end

  def empty_cart
    session[:cart] = nil
    flash[:notice] = "Cart is Empty"
   redirect_to :action => 'index'
  end

  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg 
    redirect_to :action => 'index'
  end
  def checkout
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("Cart is Empty")
    else
      @order = Order.new
    end
  end
 
  def save_order
   @cart = find_cart 
   @order = Order.new(params[:order])
   @order.add_line_items_from_cart(@cart)
   if @order.save 
    session[:cart] = nil 
    redirect_to_index("Thank you to order")
   else
    render :action => 'checkout'
   end
  end

end
