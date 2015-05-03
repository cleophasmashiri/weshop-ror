class CartsController < ApplicationController
  #before_action :authenticate_user!


  def show
    cart_ids = get_cart_items 
    @cart_products = Product.find(cart_ids)
  end


  def add      
    cart_items = set_cart_items params[:product_id]
    cart = {'cart_id'=>current_user_cart_id, 'cart_items'=>cart_items.join(',')}.to_json
    $redis.set current_user_cart_id, cart 
    render json: cart_items.size, status: 200
  end

  def remove
    respond_to do |format|
      cart_items = delete_cart_item params[:product_id]
      cart = {'cart_id'=>current_user_cart_id, 'cart_items'=>cart_items.join(',')}.to_json
      $redis.set current_user_cart_id, cart       
      format.json { render json: cart_items.size, status: 200}
      format.html {redirect_to cart_path}
    end
  end
 
  private

  include CartsHelper
  
end
