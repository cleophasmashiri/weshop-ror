module CartsHelper
   def get_cart  cart_id
    cart_id = cart_id ? cart_id : current_user_cart_id 
      cart_string = $redis.get cart_id
      if(cart_string)
        @cart = JSON.parse(cart_string)
      else
        @cart = {'cart_id'=>cart_id, 'cart_items'=>''}        
      end  
  end
  
  def get_cart_items
    cart = get_cart current_user_cart_id
    cart_items_string = cart['cart_items']
    cart_items = cart_items_string ? cart_items_string.split(',') : nil
  end

  def set_cart_items product_id
    cart_items = get_cart_items
    cart_items ? cart_items.push(product_id) : Array.new(1) {product_id} 
  end

  def delete_cart_item product_id
    cart_items = get_cart_items
    if cart_items 
     cart_items.pop(product_id.to_i)  
    end
  end

  def current_user_cart_id
    "cart3#{session.id}"
  end
end
